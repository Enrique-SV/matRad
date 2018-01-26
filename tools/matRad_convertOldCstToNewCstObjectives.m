function newCst = matRad_convertOldCstToNewCstObjectives(cst)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% converts a cst with struct array objectives / constraints to the new cst
% format using a cell array of objects
% 
% call
%    newCst = matRad_convertOldCstToNewCstObjectives(cst)
%
% input
%   cst     a cst cell array that contains the old obectives as struct
%           array
%
% output 
%   newCst  copy of the input cst with all old objectives struct arrays 
%           replaced by cell arrays of Objective objects
%
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Copyright 2015 the matRad development team. 
% 
% This file is part of the matRad project. It is subject to the license 
% terms in the LICENSE file found in the top-level directory of this 
% distribution and at https://github.com/e0404/matRad/LICENSES.txt. No part 
% of the matRad project, including this file, may be copied, modified, 
% propagated, or distributed except according to the terms contained in the 
% LICENSE file.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Copy cst
newCst = cst;

%Loop over cst to convert objectives
for m=1:size(cst,1)
    if ~isempty(cst{m,6})
        
        %Create empty cell array in the new cst
        newCst{m,6} = cell(0);
        
        %For each objective instanciate the appropriate objective object
        for n=1:numel(cst{m,6})            
            if isequal(cst{m,6}(n).type,'square deviation')
                obj = DoseObjectives.matRad_SquaredDeviation;
                obj.penalty = cst{m,6}(n).penalty;
                obj.parameters{1} = cst{m,6}(n).dose;
                newCst{m,6}{n} = obj;
                
            elseif isequal(cst{m,6}(n).type,'square overdosing')
                obj = DoseObjectives.matRad_SquaredOverdosing;
                obj.penalty = cst{m,6}(n).penalty;
                obj.parameters{1} = cst{m,6}(n).dose;
                newCst{m,6}{n} = obj;
                
            elseif isequal(cst{m,6}(n).type,'square underdosing')
                obj = DoseObjectives.matRad_SquaredUnderdosing;
                obj.penalty = cst{m,6}(n).penalty;
                obj.parameters{1} = cst{m,6}(n).dose;
                newCst{m,6}{n} = obj;
                
            elseif isequal(cst{m,6}(n).type,'min DVH objective')
                obj = DoseObjectives.matRad_MinDVH;
                obj.parameters{1} = cst{m,6}(n).dose;
                obj.parameters{2} = cst{m,6}(n).volume;
                newCst{m,6}{n} = obj;
                
            elseif isequal(cst{m,6}(n).type,'max DVH objective')
                obj = DoseObjectives.matRad_MaxDVH;
                obj.parameters{1} = cst{m,6}(n).dose;
                obj.parameters{2} = cst{m,6}(n).volume;
                newCst{m,6}{n} = obj;
                
            elseif isequal(cst{m,6}(n).type,'mean')
                obj = DoseObjectives.matRad_MeanDose;
                obj.parameters{1} = cst{m,6}(n).dose;
                newCst{m,6}{n} = obj;
                
            elseif isequal(cst{m,6}(n).type,'EUD')
                obj = DoseObjectives.matRad_EUD;
                obj.parameters{1} = cst{m,6}(n).dose;
                obj.parameters{2} = cst{m,6}(n).EUD;                
                newCst{m,6}{n} = obj;
            else
                warndlg('ERROR. Can not read file.','Loading Error');
                break;
            end
        end
    end
end







