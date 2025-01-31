-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "os1_imu",
  published_frame = "base_link",
  odom_frame = "odom",
  provide_odom_frame = false,
  publish_frame_projected_to_2d = false,
  use_odometry = false,
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 0,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 1,
  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.1,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_3d = true

TRAJECTORY_BUILDER_3D.min_range = 0.25 -- minimal distance Point Cloud -> 0.25 ouster specs
TRAJECTORY_BUILDER_3D.max_range = 5. -- maximal distance Point Cloud ->120 ouster specs

-- TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true
-- TRAJECTORY_BUILDER_2D.use_imu_data = true
-- TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.15
-- TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(35.)
-- TRAJECTORY_BUILDER_2D.min_range = 1
-- TRAJECTORY_BUILDER_2D.imu_gravity_time_constant = 1

-- POSE_GRAPH.optimization_problem.huber_scale = 1e2

TRAJECTORY_BUILDER_3D.num_accumulated_range_data = 1

--Filter the Point Cloud
TRAJECTORY_BUILDER_3D.voxel_filter_size = .05

--TRAJECTORY_BUILDER_3D.adaptive_voxel_filter.max_length = 2.
--TRAJECTORY_BUILDER_3D.adaptive_voxel_filter.min_num_points = 100.

-- Filter the motion
--TRAJECTORY_BUILDER_3D.motion_filter.max_time_seconds = 0.0
--TRAJECTORY_BUILDER_3D.motion_filter.max_distance_meters = 0.0
--TRAJECTORY_BUILDER_3D.motion_filter.max_angle_radians = 0.0 -- math.pi/2

TRAJECTORY_BUILDER_3D.submaps.num_range_data = 10

--Matching of subscans
--TRAJECTORY_BUILDER_3D.ceres_scan_matcher.occupied_space_weight = 1.
--TRAJECTORY_BUILDER_3D.ceres_scan_matcher.occupied_space_weight_0 = 1.
--TRAJECTORY_BUILDER_3D.ceres_scan_matcher.occupied_space_weight_1 = 1.

TRAJECTORY_BUILDER_3D.ceres_scan_matcher.translation_weight = 1e3
TRAJECTORY_BUILDER_3D.ceres_scan_matcher.rotation_weight = 100

TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true
TRAJECTORY_BUILDER_3D.real_time_correlative_scan_matcher.linear_search_window = 0.15
TRAJECTORY_BUILDER_3D.real_time_correlative_scan_matcher.angular_search_window = math.rad(35.)


--MAP_BUILDER.use_trajectory_builder_2d = false

--MAP_BUILDER.num_background_threads = 12

POSE_GRAPH.optimize_every_n_nodes = 0
POSE_GRAPH.constraint_builder.sampling_ratio = 0.03
POSE_GRAPH.optimization_problem.ceres_solver_options.max_num_iterations = 100
POSE_GRAPH.constraint_builder.min_score = 0.8
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.8
POSE_GRAPH.optimization_problem.huber_scale = 5e2

return options

--TRAJECTORY_BUILDER_2D.num_accumulated_range_data = 1
--TRAJECTORY_BUILDER_2D.imu_gravity_time_constant = .1
