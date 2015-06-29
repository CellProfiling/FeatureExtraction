p = '/Users/eltonrexhepaj/Working Directory/HPA CELL LINES PROJECT/IF CELL CYCLE/processed_data/G1PHASE/features/region/'
p2 = '/Users/eltonrexhepaj/Working Directory/HPA CELL LINES PROJECT/IF CELL CYCLE/processed_data/G1PHASE/original_nuc-as-prot/features/region/'
files = dir(p);
for i=1:length(files)
    if files(i).name(1) == '.'
        continue
    end
    a = load([p, files(i).name]);
    b = load([p2, files(i).name]);
    na = size(a.feats, 1);
    nb = size(b.feats, 1);
    if na ~= nb
        fprintf('Size mismatch for file %s\n%d in original, %d in original_nuc-as-prot\n', files(i).name, na, nb)
        %delete([p, files(i).name])
    end
end