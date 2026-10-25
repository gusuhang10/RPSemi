%normalizeMinMax
function x=normalizeMinMax(a)
    a_min=min(a,[],2);
    a_max=max(a,[],2);
    rng=a_max-a_min;
    rng(rng==0)=1;
    x=bsxfun(@rdivide, bsxfun(@minus,a,a_min),rng);
    deg=(a_max==a_min);
    x(deg,:)=0;
end
