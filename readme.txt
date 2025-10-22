this code is intended to plot the ballistics paths used in the build code
(repo = https://github.com/kgbemis/scoria_cone_model) and the landing 
distribution code (repo = https://github.com/kgbemis/build_landing_dist)

run_test_eject_angle_for_paths.m sets up the particle ejection parameters 
and calls test_eject_angle.m

test_eject_angle.m computes the ballistic paths and then plots them

Currently the setup in test_eject_angle.m plots the paths to the maximum 
point reached (or a little beyond).

No clipping will result in paths going below topography.

Clipping at landing has not been implemented.  Doubling the clipping time 
from the maximum reach point might be useful in assessing the landing 
relative realistic topography.

