function aux_cleardir(folderPath)
%CLEARDIR Delete all the contents of a folder and retain the empty folder.
%   Specify full path of a folder to delete all of its contents without
%   deleting the folder itself unlike 'rmdir'.

%% Identify folder contents & segregate them into files & subfolders
folderContents = dir(folderPath);
[~,folderName,folderExt] = fileparts(folderPath);   % get folder name & extension 
folderName = [folderName,folderExt];                % concatenate folder name & extension to get full name
contentList = {folderContents.name};                % get folder contents
contentIsFolder = [folderContents.isdir];           % get directory type for contents
dotElementsIds = strncmpi(contentList,'.',1);       % find indices of '.' and '..' if present (startsWith doesn't work on Matlab 2016a or earlier)
if ~isempty(dotElementsIds)                         % ignore '.' and '..' if present
    contentList = contentList(~dotElementsIds);
    contentIsFolder = contentIsFolder(~dotElementsIds); 
end               
subfolders = contentList(contentIsFolder);          % store subfolder names
files = contentList(~contentIsFolder);              % store file names

%% Delete files
if ~isempty(files)
    fprintf('Deleting files from %s....\n',folderName)
    cellfun(@(x) delete(fullfile(folderPath,x)),files)
end

%% Delete subfolders
if ~isempty(subfolders)
    fprintf('Deleting subfolders from %s....\n',folderName)
    cellfun(@(x) rmdir(fullfile(folderPath,x),'s'),subfolders)
end

end

