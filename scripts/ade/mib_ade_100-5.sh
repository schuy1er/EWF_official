#!/bin/bash

set -e

start=`date +%s`

START_DATE=$(date '+%Y-%m-%d')

PORT=$((9000 + RANDOM % 1000))
GPU=0,1,2,3
NB_GPU=4

DATA_ROOT=data/

DATASET=ade
TASK=100-5
NAME=MiB+ours
METHOD=FT
OPTIONS="--checkpoint checkpoints/step/ --loss_kd 100 --unce --unkd --init_balanced --weight_fusion --fix_pre_cls"

SCREENNAME="${DATASET}_${TASK}_${NAME} On GPUs ${GPU}"

RESULTSFILE=results/${START_DATE}_${DATASET}_${TASK}_${NAME}.csv
rm -f ${RESULTSFILE}

echo -ne "\ek${SCREENNAME}\e\\"

echo "Writing in ${RESULTSFILE}"

# If you already trained the model for the first step, you can re-use those weights
# in order to skip this initial step --> faster iteration on your model
# Set this variable with the weights path
# FIRSTMODEL=/path/to/my/first/weights
# Then, for the first step, append those options:
# --ckpt ${FIRSTMODEL} --test
# And for the second step, this option:
# --step_ckpt ${FIRSTMODEL}

CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 0 --lr 0.01 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS}
CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 1 --lr 0.001 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS} 
CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 2 --lr 0.001 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS} 
CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 3 --lr 0.001 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS} 
CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 4 --lr 0.001 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS} 
CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 5 --lr 0.001 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS} 
CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 6 --lr 0.001 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS} 
CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 7 --lr 0.001 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS} 
CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 8 --lr 0.001 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS} 
CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 9 --lr 0.001 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS} 
CUDA_VISIBLE_DEVICES=${GPU} python3 -m torch.distributed.launch --master_port ${PORT} --nproc_per_node=${NB_GPU} run.py --date ${START_DATE} --data_root ${DATA_ROOT} --overlap --batch_size 6 --dataset ${DATASET} --name ${NAME} --task ${TASK} --step 10 --lr 0.001 --epochs 60 --method ${METHOD} --opt_level O1 ${OPTIONS} 
python3 average_csv.py ${RESULTSFILE}

echo ${SCREENNAME}


end=`date +%s`
runtime=$((end-start))
echo "Run in ${runtime}s"
