function sleep_nico(fid, hours, minutes, seconds)
% INPUT: file id, seconds to sleep
% OUTPUT: none, writes xml to given file

if ~ischar(seconds)
    time_seconds = num2str(seconds);
end

fprintf(fid, strcat('<sleep>',num2str(hours),':',num2str(minutes),':',num2str(seconds),'</sleep>\n'));

end
