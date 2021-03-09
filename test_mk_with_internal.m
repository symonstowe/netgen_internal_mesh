shapes = shape_library('get','lamb_newborn');
ext   = shapes.boundary;
lungs = shapes.lungs;
heart = shapes.heart;

maxsz = 0.1;
trunk_shape = {1,{ext,lungs,heart},[4,20],maxsz};
elec_pos = [14,0,[0.4,0.6]]; % Only 28  external electrodes 
elec_shape = [0.05];
% TODO 1 for shpere 0 for cyl
% 0 for hollow probe 1 for only electrodes
%probe_specifications = [x_location, y_location, radius, elec_height, elec_maxh, [elec_planes]];
probe = [0,0.2,0.05,0.05,0.2,[linspace(0.3,0.7,4)]];

[fmdl, mat_idx]  = ng_mk_extruded_model_internal(trunk_shape,elec_pos,elec_shape,probe);
num_opts.ext_elecs = 28; % -> number of external electrodes
num_opts.ext_rows  = 2; %-> number of vertical electrode rows
num_opts.int_elecs = 4; %-> number of internal electrodes
num_opts.offset    = 0;%-> electrode offset from centre (sternum) in degrees (default 0)
num_opts.pattern   = 'square'; %-> application pattern for external electrodes (default 'square')
% TODO this renumbering only works with round tanks - doesn't look at the boundary.... Fix it!!
coords = [-0.24, 0.98,0.6;
          -0.24, 0.98,0.4;
          -0.48, 0.55,0.4;
          -0.48, 0.55,0.6;
          -0.59, 0.22,0.6;
          -0.59, 0.22,0.4;
          -0.69,-0.06,0.4;
          -0.69,-0.06,0.6;
          -0.72,-0.42,0.6;
          -0.72,-0.42,0.4;
          -0.56,-0.77,0.4;
          -0.56,-0.77,0.6;
          -0.21,-0.96,0.6;
          -0.21,-0.96,0.4;
           0.21,-0.97,0.4;
           0.21,-0.97,0.6;
           0.56,-0.76,0.6;
           0.56,-0.76,0.4;
           0.73,-0.41,0.4;
           0.73,-0.41,0.6;
           0.69,-0.07,0.6;
           0.69,-0.07,0.4;
           0.60, 0.22,0.4;
           0.60, 0.22,0.6;
           0.48, 0.54,0.6;
           0.48, 0.54,0.4;
           0.23, 0.95,0.6;
           0.23, 0.95,0.4;
           probe(1),probe(2),probe(9);
           probe(1),probe(2),probe(8);
           probe(1),probe(2),probe(7);
           probe(1),probe(2),probe(6);];

[fmdl] = renumber_electrodes( fmdl, coords, 0) ;
tiledlayout(2,1,'Padding', 'none', 'TileSpacing', 'compact');
nexttile; show_fem(fmdl, [0,1.04]); axis off;
%[fmdl, mat_idx]  = ng_mk_extruded_model(trunk_shape,elec_pos,elec_shape);
img = mk_image(fmdl, 1); % background conductivity
img.elem_data(fmdl.mat_idx{2}) = 0.3; % Lungs
img.elem_data(fmdl.mat_idx{3}) = 1.2; % Heart
nexttile; show_fem(img); axis off;