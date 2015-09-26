## Variable Selection

The data in this data set come from measurements made by the accelerometer and 
gyroscope in a Samsung Galaxy II Smartphone, while subjects undertook one of six
activities (Walking, Walking Up Stairs, Walking Down Stairs, Sitting, Standing, Laying).  
These devices recorded, respectively, acceleration along 3 axes, and angular velocity 
along three axes.  These measurements were taken at a rate of 50hz, and recorded in a
time series.  From these initial measurements, the following vectors were estimated

Body Acceleration (along three axes)
Acceleration due to Gravity (along three axes)
Body Jerk (along three axes)
Body Angular Velocity (along three axes)
Body Angular Velocity Jerk (along three axes)
Body Accelertion Magnitude
Magnitude of Acceleration due to Gravity
Magnitude of Body Jerk
Magnitude of Body Angular Velocity
Magnitude of Body Jerk's Angular Velocity

Subsequently, a Fast Fourier Transform was applied to some of these vectors, resulting
in the

Fourier Body Acceleration (along three axes)
Fourier Body Jerk (along three axes)
Fourier Body Angular Velocity (along three axes)
Fourier Body Accelertion Magnitude
Fourier Magnitude of Body Jerk
Fourier Magnitude of Body Angular Velocity
Fourier Magnitude of Body Jerk's Angular Velocity

For each of these vectors, a number of variables were estimated, creating in total
561 different variables recorded for each subject.

## New Tidy Data Set

In our Tidy data set, we have extracted only the estimated means, standard deviations,
and mean frequency of the above vectors.  This reduces the dataset from 561 variables
to 88.  For each of these variables, we have then taken the average (mean) value over
the entire time series, and reported this average value in the outputted table.