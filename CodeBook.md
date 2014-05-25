# Code book

This code book describes the raw data and how we transformed it
to produce the tidy data.

The raw data has been split into two non intersecting groups for training and test data.

Each group has its own folder but follows similar naming conventions.

The following files have all the same number of line corresponding to one window of observation.
- `train/subject_train.txt` or `test/subject_test.txt` have the subject ID.
- `train/X_train.txt` or `test/X_test.txt` have the feature measures.
- `train/Y_train.txt` or `test/Y_test.txt` have the number corresponding to an activity
(walking, walking upstairs, walking downstairs, sitting, standing or laying).

Additionally, `features.txt` gives the variable name for each measure of the `X_*` files
and `activity_labels.txt` gives an activity name corresponding to the activity number of the `Y_*` files.

The measurements concern time domain signal (names beginning with t,) and frequency domain signals (names beginning with f). They are
further divided into Body or Gravity, linear (Acc)eleration or angular velocity (Gyro) and finally as a vector (XYZ) or (Mag)nitude.
Jerk signals were also derived.

E.g. tBodyGyroJerkMag is the magnitude of the jerk of the body angular velocity measured in time domain.

Variables concerning the mean, standard deviation and others have been created form these measurements.

We will merge all these files together. In our case, we will only keep mean and standard deviation measurements.
Furthermore, I have chosen to keep only the frequency domain signals variables, as they form the more refined data.
We will transform the variable names a bit, since their format is unwieldy for R, having parentheses and commas.

Once we have one dataset for all this information, we will produce a tidy data set with a descriptive activity name instead
of just a number, and present the average of each variable, broken down by subjects and activities.

I'm using underscores in the tidy data set column names as it seems to be
alright to do now: [hipsteR](http://kbroman.github.io/hipsteR/).
