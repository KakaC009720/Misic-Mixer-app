recObj=  audiorecorder;
disp('Start  speaking.')  
recordblocking(recObj,3);  
disp('End  of  Recording.');
play(recObj);