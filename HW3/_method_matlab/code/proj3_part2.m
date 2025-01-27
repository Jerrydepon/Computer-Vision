% This script 
% (1) Loads 2D points from image pairs and the images themselves
% (2) Estimates the fundamental matrix                     (you code this)
% (3) Draws the epipolar lines on images
    
clear
close all
format long
choose = 5;
if choose == 1
    path_p = './Stereo_images/image11.png';
    path_q = './Stereo_images/image12.png';
    f0_txt1 = './Detected_points/f0_1_1.txt';
    f0_txt2 = './Detected_points/f0_1_2.txt';
    f1_txt1 = './Detected_points/f1_1_1.txt';
    f1_txt2 = './Detected_points/f1_1_2.txt';
elseif choose == 2
    path_p = './Stereo_images/image21.png';
    path_q = './Stereo_images/image22.png'; 
    f0_txt1 = './Detected_points/f0_2_1.txt';
    f0_txt2 = './Detected_points/f0_2_2.txt';
    f1_txt1 = './Detected_points/f1_2_1.txt';
    f1_txt2 = './Detected_points/f1_2_2.txt';
elseif choose == 3
    path_p = './Stereo_images/image31.png';
    path_q = './Stereo_images/image32.png';
    f0_txt1 = './Detected_points/f0_3_1.txt';
    f0_txt2 = './Detected_points/f0_3_2.txt';
    f1_txt1 = './Detected_points/f1_3_1.txt';
    f1_txt2 = './Detected_points/f1_3_2.txt';
elseif choose == 4
    path_p = './Stereo_images/image41.png';
    path_q = './Stereo_images/image42.png';
    f0_txt1 = './Detected_points/f0_4_1.txt';
    f0_txt2 = './Detected_points/f0_4_2.txt';
    f1_txt1 = './Detected_points/f1_4_1.txt';
    f1_txt2 = './Detected_points/f1_4_2.txt';
elseif choose == 5
    path_p = './Stereo_images/image51.png';
    path_q = './Stereo_images/image52.png';
    f0_txt1 = './Detected_points/f0_5_1.txt';
    f0_txt2 = './Detected_points/f0_5_2.txt';
    f1_txt1 = './Detected_points/f1_5_1.txt';
    f1_txt2 = './Detected_points/f1_5_2.txt';
end

formatSpec = '%f';
size2d_norm = [2 Inf];

% file_2d_pic_a = fopen('./data/pts2d-pic_a.txt','r');
% file_2d_pic_b = fopen('./data/pts2d-pic_b.txt','r');
% file_2d_pic_a = fopen('./1_1.txt','r');
% file_2d_pic_b = fopen('./1_2.txt','r');
file_2d_pic_a = fopen(f0_txt1,'r');
file_2d_pic_b = fopen(f0_txt2,'r');
file_2d_pic_a2 = fopen(f1_txt1,'r');
file_2d_pic_b2 = fopen(f1_txt2,'r');

Points_2D_pic_a = fscanf(file_2d_pic_a,formatSpec,size2d_norm)';
Points_2D_pic_b = fscanf(file_2d_pic_b,formatSpec,size2d_norm)';
Points_2D_pic_a2 = fscanf(file_2d_pic_a2,formatSpec,size2d_norm)';
Points_2D_pic_b2 = fscanf(file_2d_pic_b2,formatSpec,size2d_norm)';

% ImgLeft  = imread('./data/pic_a.jpg');
% ImgRight = imread('./data/pic_b.jpg');
ImgLeft  = imread(path_p);
ImgRight = imread(path_q);


% %(Optional) You might try adding noise for testing purposes:
%  Points_2D_pic_a = Points_2D_pic_a + 6*rand(size(Points_2D_pic_a))-0.5;
%  Points_2D_pic_b = Points_2D_pic_b + 6*rand(size(Points_2D_pic_b))-0.5;

%% Calculate the fundamental matrix given corresponding point pairs
%% WITHOUT Normalization
F0_matrix = estimate_fundamental_matrix(Points_2D_pic_a, Points_2D_pic_b);
[U,S,V] = svd(F0_matrix);
disp('F0: ')
disp(F0_matrix)

disp('epipole for F0 in image1: ')
V = V(:,3);
V = V/V(3,:);
V = V(1:2,:);
fprintf('x: %f\n',V(1,:))
fprintf('y: %f\n\n',V(2,:))

disp('epipole for F0 in image2: ')
U = U(:,3);
U = U/U(3,:);
U = U(1:2,:);
fprintf('x: %f\n',U(1,:))
fprintf('y: %f\n\n',U(2,:))

F1_matrix = estimate_fundamental_matrix(Points_2D_pic_a2, Points_2D_pic_b2);
[U1,S1,V1] = svd(F1_matrix);
% disp('F1: ')
% disp(F1_matrix)

disp('epipole for F1 in image1: ')
V1 = V1(:,3);
V1 = V1/V1(3,:);
V1 = V1(1:2,:);
fprintf('x: %f\n',V1(1,:))
fprintf('y: %f\n\n',V1(2,:))

disp('epipole for F1 in image2: ')
U1 = U1(:,3);
U1 = U1/U1(3,:);
U1 = U1(1:2,:);
fprintf('x: %f\n',U1(1,:))
fprintf('y: %f\n\n',U1(2,:))

%% WITH NORMALIZATION
% F_matrix = Normalized_estimate_fundamental_matrix(Points_2D_pic_a, Points_2D_pic_b);

%% Draw the epipolar lines on the images
draw_epipolar_lines(F0_matrix,F1_matrix,ImgLeft,ImgRight,Points_2D_pic_a,Points_2D_pic_b,V,V1,U,U1);

