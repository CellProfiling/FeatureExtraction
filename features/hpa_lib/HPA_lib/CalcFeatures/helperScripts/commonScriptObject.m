
feats = zeros(1,18);
if optimize && protein_channel_blank
    feats(:) = nan;
else
    
    if isempty(protobjs)
        feats([1:5]) = nan;
        %feats(6:18) = nan;
    else
        
        feats(1) = mean(protobjs);
        feats(2) = var(protobjs);
        try
            feats(3) = max(protobjs)/min(protobjs);
        catch
            %keyboard
            if isempty(protobjs)
                feats(3)=0;
            else
                error('Check protobjs!');
            end
        end
        
        feats(4) = length(protobjs)/length(nucobjs);
        feats(5) = normEuN;
    end
    
    if isempty(protobjs_mthr)
        feats([6:10 15:18]) = nan;
        %feats(6:18) = nan;
    else
        feats(6) = mean(protobjs_mthr);
        feats(7) = var(protobjs_mthr);
        feats(8) = max(protobjs_mthr)/min(protobjs_mthr);
        feats(9) = length(protobjs_mthr)/length(nucobjs);
        feats(10) = normEuN_mthr;
        
        feats(15) = mean(largeprotobjs_mthr);
        feats(16) = var(largeprotobjs_mthr);
        feats(17) = max(largeprotobjs_mthr)/min(largeprotobjs_mthr);
        feats(18) = length(largeprotobjs_mthr)/length(nucobjs);
    end
    
    if(isempty(largeprotobjs))
        feats([11:14]) = nan;
    else
        feats(11) = mean(largeprotobjs);
        feats(12) = var(largeprotobjs);
        feats(13) = max(largeprotobjs)/min(largeprotobjs);
        feats(14) = length(largeprotobjs)/length(nucobjs);
    end
    
end

names = {'Avg. # pixels per obj.','Var. of # pixels per obj.','Ratio of size of largest obj. to smallest', 'nuc: # prot objs to nuc objs','normalized Euler number', ...
    'Avg. # pixels per obj._mthr','Var. of # pixels per obj._mthr','Ratio of size of largest obj. to smallest_mthr', 'nuc: # prot objs to nuc objs_mthr','normalized Euler number_mthr', ...
    'Avg. # pixels per large obj.','Var. of # pixels per large obj.','Ratio of size of largest large obj. to smallest', 'nuc: # large prot objs to nuc objs', ...
    'Avg. # pixels per large obj._mthr','Var. of # pixels per large obj._mthr','Ratio of size of largest large obj. to smallest_mthr', 'nuc: # large prot objs to nuc objs_mthr'};
slfnames = {'SLF1.3','SLF1.4','SLF1.5','prottonuc','SLF1.2','SLF1.3.3mthr' ,'SLF1.4.3mthr','1.5.3mthr','prottonuc_mthr','1.2.3mthr','SLF1.3.2large','SLF1.4.2large','SLF1.5.2large','prottonuc_large','SLF1.3.4large_mthr','1.4.4large_mthr','1.5.4large_mthr','prottonuclarge_mthr'};
