function P = permmat(M, N)
% PERMMAT  Permutation matrix
%
%   P = PERMMAT(M,N) will generate a MN by MN permutation matrix.  For a
%   given matrix A that is MN x MN, with an M x M pattern of N x N blocks,
%   the product P'*A*P will return a matrix that has an N x N pattern of 
%   M x M blocks achieved by swapping the levels.
%
%
%    Written By:     Christopher K. Turnes
%                    Georgia Institute of Technology
%    Created:        27-Dec-2011
%    Last Modified:  28-Dec-2011
%
%

    ix = (1:(M*N)).';
    iy = zeros(M*N, 1);
    for i = 1:M
        for j = 1:N
            iy((i-1)*N + j) = (j-1)*M + i;
        end
    end
    P = sparse(ix, iy, 1, M*N, M*N);

end
