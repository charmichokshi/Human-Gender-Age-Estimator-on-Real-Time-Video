% Tyler Phillips
% phillity@umail.iu.edu
% February 12, 2018

%load('all_data_labels.mat')
%load('Y_dependent.mat')
%load('File_test.mat')
%% Bio-Inspired Feature Extraction

% G. Guo, Guowang Mu, Y. Fu and T. S. Huang, 
% "Human age estimation using bio-inspired features," 
% 2009 IEEE Conference on Computer Vision and Pattern Recognition, Miami, FL, 2009, pp. 112-119.

% http://ieeexplore.ieee.org/document/5206681/
%%'
%%
load('age estimation/File_train.mat')
load('age estimation/File_test.mat')

%%  mainn!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% load('Y_train_data.mat')

%%
disp('hello')
size = 100 ;
rotation = 12;
band = 8;
component = 20;

size_str = num2str(size);
base_train = 'data/train_';
base_test = 'data/test_';
train_base_path = strcat(base_train,size_str);
train_base_path1 = strcat(train_base_path,'/');
test_base_path = strcat(base_test,size_str);
test_base_path1 = strcat(test_base_path,'/');
File_train = dir(train_base_path1);
File_test = dir(test_base_path1);

disp('done paths.')
% Created matrix of dependent variables (1st column : age, 2nd column: gender (female:1,male:0))
%Y_train_Age_gender = zeros(length(File_train)-3,2);
Y_ageLabel = zeros(length(File_train)-3,1);
for k=1:length(File_train)-3
    FileNames = File_train(k+2).name ;
    age = str2num(FileNames(7:8));
    %Y_train_Age_gender(k,1) = age;
    %Y_train_Age_gender(k,2) = str2num(FileNames(2));
    if age <= 12
        Y_ageLabel(k,1) = 1 ;
    elseif age <=35
        Y_ageLabel(k,1) = 2 ;
    elseif age <=55
        Y_ageLabel(k,1) = 3 ;
    else
        Y_ageLabel(k,1) = 4 ;
    end
end

n = length(File_train)-3;

Y_return = bif(strcat(train_base_path1,File_train(3).name), band, rotation);
Y_return = radbas(Y_return);
%col = length(Y_return');

load('z100.mat')
mdl = fitcknn(z,Y_ageLabel);
disp('Done independent variable.');
%Prediction
pred = zeros(length(File_test)-3,1);
Y_test_ageLabel = zeros(length(File_test)-3,1);
for i = 1:length(File_test)-3

    % code to call bif for each image iterativly
    Y_test = bif(strcat(test_base_path1,File_test(i+2).name), band, rotation);

    Y_test = radbas(Y_test);
    pred(i,1) = predict(mdl, Y_test);
    
    % getting true age label of test image
    FileAge = File_test(k+2).name;
    Y_test_Age = str2num(FileAge(7:8));
    if age <= 12
        Y_test_ageLabel(i,1) = 1 ;
    elseif age <=35
        Y_test_ageLabel(i,1) = 2 ;
    elseif age <=55
        Y_test_ageLabel(i,1) = 3 ;
    else
        Y_test_ageLabel(i,1) = 4 ;
    end
end
disp('Done prediction.')
%checking accuracy of omn 61 test images
wrong = 0;
for i=1:length(File_test)-3
    if(Y_test_ageLabel(i,1) ~= pred(i,1))
        wrong = wrong + 1;
    end
end

ageLabel_accuracy = 1 - (wrong/(length(File_test)-3));

g_accuracy = 'gaccLabel';
g_accuracy = strcat(g_accuracy, size_str);
g_accuracy = strcat(g_accuracy, '.mat');
save(g_accuracy,'ageLabel_accuracy');

disp('Done saving.')
    




% AgeMale = zeros(length(Files_male),2)
% for k=1:length(Files_male) 
%    FileNames = Files_male(k).name ;
%    AgeMale(k,1) = str2num(FileNames(7:8))
%    AgeMale(k,2) = 0
% end
%%

%READ THE FOLLOWING 

%our code will look like this

% n is no of images

%%

%%
%[XL,YL,XS,YS,BETA] = plsregress(z,Y_train_Age_gender(1:end,1),20);


%%

%% checking for one image

%Y_test = bif(strcat(base_path1,Files(218).name), 2, 3);
%% 



disp('aya ke nai')
disp('first')