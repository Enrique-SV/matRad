function shapeInfo = tk_getSequencingParameters(seqResult,pln,stf)

% initializing variables
x_l = [];
x_r = [];
shapeIx = [];
shapeCounter = 0;
numOfShapes = ones(pln.numOfBeams,1);
zPos = [];


% loop over all beams
for i=1:pln.numOfBeams
    
    % get number of shapes for each beam
    numOfShapes(i) = seqResult.beam(i).numOfShapes;
    
    % get z-coordinates of leafes
    Z = ones(stf(i).numOfRays,1)*NaN;
    
    for k=1:stf(i).numOfRays
        Z(k) = stf(i).ray(k).rayPos_bev(:,3);
    end
    Z = unique(Z); % get the position of the leaf pairs
    
    % loop over all shapes
    for j=1:seqResult.beam(i).numOfShapes
        shapeCounter = shapeCounter +1; % get index of current shape
        tempShape = seqResult.beam(i).shapes(:,:,j);
        [Ix_l, Ix_r] = tk_getLeafPos(tempShape);
        
        %visualize shape
        figure
        titleString = ['BeamNr: ' int2str(i) ' ShapeNr: ' int2str(j)];
        tk_visSingleShape(tempShape,Ix_l,Ix_r,titleString)
        title(sprintf(['BeamNr: ' int2str(i) ' ShapeNr: ' int2str(j)],'Fontsize',14))
        close all
        x_l = [x_l; Ix_l];
        x_r = [x_r; Ix_r];
        shapeIx = [shapeIx; shapeCounter*ones(size(Ix_l,1),1)];
        zPos = [zPos; Z];
    end
    
% %     % get x-coordinates of leafes
% %     X = ones(stf(i).numOfRays,1)*NaN;
% %     
% %     for k=1:stf(i).numOfRays
% %         X(k) = stf(i).ray(k).rayPos_bev(:,1);
% %     end
% %     X = unique(X); % get the position of the leaf pairs
    
    
end

shapeInfo.x_l = x_l;
shapeInfo.x_r = x_r;
shapeInfo.zPos = zPos;
shapeInfo.shapeIx = shapeIx;
shapeInfo.numOfShapes = numOfShapes;

    
end