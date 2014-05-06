
% Compute the proportions of each region in each atlase and variance
% among atlases



rng(1); % in order to reproduce results

nClasses = 138;
fileList = listMICCAI('./');
nFiles = length(fileList);

classesProp = zeros(nFiles,nClasses);

parfor i = 1:nFiles
    
    % Open and crop the image to only keep the brain
    [mri, label] = openNII(fileList{i}, false);
    [mri, label] = cropImg(mri, label);
    mri.img(label.img == 0) = 0; % Only keep the brain
    dims = size(mri.img);
    
    [a,b] = hist(label.img(:), 0:nClasses);
    if ~any(a)
        disp('Problem, this file is missing a region!!!');
    end
    classesProp(i,:) = a(2:end); % Remove class 0 (no region)
end


classesProp = bsxfun(@rdivide, classesProp, sum(classesProp,2));

propMean = mean(classesProp);
propVar = std(classesProp);

boxplot(classesProp, 'plotstyle','compact')

[propSort, idx] = sort(propMean);
propVar(idx);