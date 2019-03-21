d=dir('*P1*');  
%d=dir('*test*');
filename=d.name;

  mo=moviereader(filename);
  FR=mo.FrameRate;
  fs=mo.read();
  N_frames= size(fs,3);


  %%%% on single cell %%%%
  
  s=std(double(fs(:,:,1:100)),[],3);
  BW=roipoly(mat2gray(s));
  fs_roi= fs(repmat(BW,[1,1,N_frames]));
  roi=reshape(fs_roi,[sum(BW(:)),N_frames]);
  roi=double(roi)-repmat((mean(roi,2)),[1,size(roi,2)]);


 % pxx is a matrix with the spectrum of each pixel as a column
%c_roi = AutoCorr(double(roi'),floor(N_frames/2));

%%%% periodogram needs time on the row and pixel on the coloun; 
N_seg=1;
window = hann(floor(N_frames)/N_seg);
[pxx, fq] = periodogram(double(roi(1,:)),window,numel(roi(1,:)),FR);
m_pxx=zeros(size(pxx));

for jj=1:size(roi,1)
	temp_roi=double(roi(jj,:));

%[pxx, fq]=pwelch(double(c_roi), window,50,size(c_roi,1),FR);
	[pxx, fq] = periodogram(temp_roi,window,numel(temp_roi),FR);
%     [pwxx, frequencies] = pwelch(temp_fs,wwindow,[],numel(wwindow),FR);

	m_pxx=m_pxx +pxx;
end

m_pxx=m_pxx/size(roi,1);


figure(); plot(fq(10:end),m_pxx(10:end)); xlabel('[Hz]'),ylabel('fft');
  %%%-bg_pxx(5:end)%%%
 
