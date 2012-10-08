function R = convfft(M,v)
% Convolution of a matrix and a vector
% uses the same algo as Bruno Luong's convnfft
% copied from temporalMP.m in Matlab's File Exchange

    nsize = size(M,2)+length(v)-1;
    v_fft = fft(v,nsize);
    M_fft = fft(M,nsize,2);
    R  = ifft(bsxfun(@times,v_fft,M_fft),[],2);
end
