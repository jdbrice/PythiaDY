#!/bin/bash
date

mkdir -p script log output

echo "Universe     = vanilla">runAll_all.job
echo "Notification = never">>runAll_all.job
echo "Requirements = (CPU_Type != \"crs\") && (CPU_Experiment == \"star\")">>runAll_all.job
echo "Initialdir   = $PWD">>runAll_all.job
echo "GetEnv       = True">>runAll_all.job
echo "+Experiment  = \"star\"">>runAll_all.job
echo "+Job_Type    = \"cas\"">>runAll_all.job
echo "">>runAll_all.job
echo "">>runAll_all.job

count=0
#while [ $count -le 100 ] 
while [ $count -le 1 ] 
do

  echo $count
  echo "#!/bin/bash">script/run_${count}.sh
  echo "">>script/run_${count}.sh
  
  echo "root -l -b <<EOF ">>script/run_${count}.sh
  echo ".O2" >> script/run_${count}.sh 
  echo ".L runhfevent_C.so">> script/run_${count}.sh
  echo -n "runhfevent(">>script/run_${count}.sh
  echo -n ${count}>>script/run_${count}.sh
  echo -n ",1000000,">>script/run_${count}.sh
  echo -n $RANDOM>>script/run_${count}.sh
  echo -n ",0">>script/run_${count}.sh
  echo ")">>script/run_${count}.sh 
  echo ".q">>script/run_${count}.sh      
  echo "EOF">>script/run_${count}.sh 

  chmod 755 script/run_${count}.sh
	
  echo "Executable     = script/run_${count}.sh">>runAll_all.job
  echo "Output         = log/run_${count}.out" >> runAll_all.job
  echo "Error          = log/run_${count}.err" >> runAll_all.job
  echo "Log            = log/run_${count}.log" >> runAll_all.job
  echo "Queue"         >> runAll_all.job
  echo  "     " >>runAll_all.job
	
  let "count=count+1" 

done   

condor_submit runAll_all.job

