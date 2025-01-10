#!/bin/bash

#set -x
#function to check the pod status for a namespace
check_pod_status() {
 local NAMESPACE="$1"

#local POD_STATUS=$(kubectl get pods -o jsonpath='{range .items[]}{range .status.containerStatuses[]}{.ready}{end}{.metadata.name}{ "\n"}{end}' -n $NAMESPACE)
 local POD_STATUS=$(kubectl get pods -o jsonpath='{range .items[]}{.metadata.name}{"\t"}{range .status.containerStatuses[]}{.ready}{" "}{end}{ "\n"}{end}' -n $NAMESPACE)

 local TOTAL_PODS=$(echo "$POD_STATUS" | wc -l)

#local UP_PODS=$(awk '$2=="true"{up++;print $1} END{print up}' <<< "$POD_STATUS")
#local UP_PODS=$(awk '$2=="true"{up++;print $1} END{if(up==""){up=0} print up}' <<< "$POD_STATUS")
 local UP_PODS=$(awk '$2=="true"{up++} END{print (up=="" ? 0 : up)}' <<< "$POD_STATUS")

#local DOWN_PODS=$(awk '$2!="true"{down++} END{print down}' <<< "$POD_STATUS")
#local DOWN_PODS=$(awk '$2!="true"{down++; print $1} END{if(down==""){down=0} print down}' <<< "$POD_STATUS")
 local DOWN_PODS=$(awk '$2!="true"{down++} END{print (down=="" ? 0 : down)}' <<< "$POD_STATUS")
 
 echo "Pod status in namespace: $NAMESPACE"
 echo "Total Pods: $TOTAL_PODS"
 echo "Pod Up: $UP_PODS"
 echo "Pods Down: $DOWN_PODS"

#Print pod names
 echo "Up Pods Names:" 
 echo "$POD_STATUS" | awk '$2=="true"{print $1}'
 echo "Down Pods Names:" 
 echo "$POD_STATUS" | awk '$2!="true"{print $1}'


#Return 0 if all pods are up otherwise return 1
if [ "$UP_PODS" -eq "$TOTAL_PODS" ]; then 
   return 0
else
   return 1
fi
}

#check if any argument is passed or not
if [ $# -eq 0 ]; then 
    echo "Error: Please specify at least one namespace."
    exit 1
fi

#function to compare pod statuses and notify if there are changes
monitor_pod_status() {
    local NAMESPACE="$1"
    local MAX_RETRIES=2
    local RETRY_COUNT=0

#if all pods are ready exit the loop
while true; do
      check_pod_status "$NAMESPACE"
    
if [ $? -eq 0 ]; then
    echo "All pods are up and running in Namespace"
    break
fi

RETRY_COUNT=$((RETRY_COUNT + 1))

if [ "$RETRY_COUNT" -ge "$MAX_RETRIES" ]; then 
 echo "Reached maximum number of retries. Exiting."
 break
fi

sleep 2 #check every 2 sec
done
}

#Start monitoring pod status for each namespace provided as arguements
for NAMESPACE in "$@"; do 
   monitor_pod_status "$NAMESPACE" 
   echo "----------------------------------------------------------------------------------------------------"
done