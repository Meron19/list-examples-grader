CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then
    echo "File Found!"
else
    echo "File Not Found"
    exit 1
fi

cp student-submission/ListExamples.java grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area


javac -cp $CPATH grading-area/*.java 2> err-output.txt
if [[ $? != 0 ]]
then
    echo "Compile error"
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore grading-area/TestListExamples > junit-output.txt


FAILURE1=`grep -c "Failures: 1" junit-output.txt`
FAILURE2=`grep -c "Failures: 2" junit-output.txt`
FAILURE3=`grep -c "Failures: 3" junit-output.txt`
FAILURE4=`grep -c "Failures: 4" junit-output.txt`

if [[ $FAILURE1 -ne 0 ]]
then 
    echo "Score 3/4"
elif [[ $FAILURE2 -ne 0 ]]
then
    echo "Score 2/4"
elif [[ $FAILURE3 -ne 0 ]]
then
    echo "Score 1/4"
elif [[ $FAILURE4 -ne 0 ]]
then
    echo "Score 0/4"
else
    echo "Score 4/4"
fi
# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests