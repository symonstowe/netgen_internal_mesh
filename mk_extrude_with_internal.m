% Make an extruded model with internal electrodes at either centroid or selected point

% Electrode location
elec_loc = [0,0.325];

% we cant to combine the mk_extrude model:

% with the internal probe from:
% http://eidors3d.sourceforge.net/tutorial/netgen/netgen_gen_models.shtml

% Get the exterior and lung shapes
shapes = shape_library('get','lamb_newborn');
ext   = shapes.boundary;
lungs = shapes.lungs;
heart = shapes.heart;

figure(1)
clf
plot(ext(:,1),ext(:,2))
hold on
plot(heart(:,1),heart(:,2));
plot(lungs(:,1),lungs(:,2));
plot(elec_loc(1), elec_loc(2),'o');

% now try to mesh it... 
maxsz = 0.1;
trunk_shape = {1,ext,[4,20],maxsz};
elec_pos = [14,0,[0.4,0.6]]; % Only 28  external electrodes 
elec_shape = [0.05];

[fmdl,mat_idx] = ng_mk_extruded_model(trunk_shape, elec_pos, elec_shape); %, extra_ng_code);
figure(2)
show_fem(fmdl);




