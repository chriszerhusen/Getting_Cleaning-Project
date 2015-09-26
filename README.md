# Getting and Cleaning Data Project

This R script reads and modifies data from the UCI HAR dataset found here

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and outputs a text file containing a cleaned up data set.

The data come from a study on recognizing different human activities from measurements
that can be gathered from a smartphone's accelerometer and gyroscope.  In the study
30 subjects each performed 6 different activities (Walking, Walking Up Stairs, 
Walking Down Stairs, Sitting, Standing, Laying) wearing a Samsung Galaxy S II on their
waist.  The following measurements were recorded:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

=====================================================================================

## Using the script

To use the run_analysis.R script, you must download and extract the data to your
working directory.  Then simply run the script.


## What the script does

### Reads and Consolidates the data

The run_analysis.R script first consolidates and then pares down the data into a 
cleaner form.  The data in the original data file are stored in a number of files.
Subjects were randomly assigned to be in one of two groups after the measurements 
were taken, and their data split up.  The first thing this script does is recombine
these two groups into one large data set.  While doing so, the script also grabs the
variable names for the columns of the data set from yet another file to attach to the
large table it is creating.

### Extracts a subset of the variables

The whole data set contains has 561 variables, but we are only interested in the 86
that contain measurements of various means and standard deviations.  A description of
these variables can be found in the accompanying codebook.  The script separates these
variables from the rest and renames them in an easier to read format.

### Creates a new table tidy data set with values averaged

The script then creates a new table to hold the tidy dataset output.  The original 
data include measurements taken every 20 miliseconds over a period of time.  The tidy
data set takes the average (mean) value of these measurements over this time period
for each unique variable, subject, and activity triad.  The result is a table with 180 
rows (30 subjects each performing 6 different tasks), and 88 columns (one for the 
subject, one for the activity, and one for each of the 86 variables extracted).

This new table is then written to a "Clean Data.txt" file created in your working 
directory.