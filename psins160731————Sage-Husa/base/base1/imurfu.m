function wvm = imurfu(wvm0, dirstr)
% In PSINS toolbox, Right-Forward-Up orientations are selected as body
% frame axes X-Y-Z respectively. Call this function when the user's 
% SIMU outputs does not follow the above convention.
%
% Prototype: wvm = imurfu(wvm0, dirstr)
% Inputs: wvm0 - the user's raw SIMU data
%         dirstr - raw SIMU X-Y-Z orientations including three characters, 
%               the orientation abbreviations are:
%               'U': Upper; 'D': Down; 'R': Right; 'L': Left; 
%               'F': Forword; 'B': Back
% Output: wvm - SIMU data with X-Y-Z pointing to R-F-U respectively
%
% See also  imurot, imuresample, insupdate, trjsimu.

% Copyright(c) 2009-2014, by Gongmin Yan, All rights reserved.
% Northwestern Polytechnical University, Xi An, P.R.China
% 02/06/2009
    wvm = wvm0;    Dir = zeros(3);
    clm = size(wvm, 2);
    for k=1:3
        switch(upper(dirstr(k)))
            case {'R'}
                wvm(:,1) = wvm0(:,k);  if clm>=6, wvm(:,4) = wvm0(:,k+3); end
                Dir(:,k) = [1; 0; 0];
            case {'L'}
                wvm(:,1) = -wvm0(:,k); if clm>=6, wvm(:,4) = -wvm0(:,k+3); end
                Dir(:,k) = [-1; 0; 0];
            case {'F'}
                wvm(:,2) = wvm0(:,k);  if clm>=6, wvm(:,5) = wvm0(:,k+3); end
                Dir(:,k) = [0; 1; 0];
            case {'B'}
                wvm(:,2) = -wvm0(:,k); if clm>=6, wvm(:,5) = -wvm0(:,k+3); end
                Dir(:,k) = [0; -1; 0];
            case {'U'}
                wvm(:,3) = wvm0(:,k);  if clm>=6, wvm(:,6) = wvm0(:,k+3); end
                Dir(:,k) = [0; 0; 1];
            case {'D'}
                wvm(:,3) = -wvm0(:,k); if clm>=6, wvm(:,6) = -wvm0(:,k+3); end
                Dir(:,k) = [0; 0; -1];
           otherwise
                error('Orientation character string error !');
        end
    end
    if(norm(cross(Dir(:,1),Dir(:,2))-Dir(:,3))~=0)
        error('Not right hand frame !');
    end
