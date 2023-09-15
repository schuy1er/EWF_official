# EWF_official(CVPR 2023)
An official code for "Endpoints Weight Fusion for Class Incremental Semantic Segmentation"

This repository contains the official implementation of the following paper:
> **Endpoints Weight Fusion for Class Incremental Semantic Segmentation**<br>
> Jia-wen Xiao, Chang-bin Zhang, Jiekang Feng, Xialei Liu<sup>*</sup>, Joost van de Weijer, Ming-Ming Cheng<br>
> IEEE/CVF Conference on Computer Vision and Pattern Recognition (**CVPR**), 2023<br>

[[Paper](https://openaccess.thecvf.com/content/CVPR2023/papers/Xiao_Endpoints_Weight_Fusion_for_Class_Incremental_Semantic_Segmentation_CVPR_2023_paper.pdf)]
[[Project Page(Comming Soon)]()]

##  Update

- [√] Release the training and evaluation code on Pascal-VOC 2012 for EWF.
- [ ] Init code for Classification with EWF.
- [ ] Add ADE20K training scripts for EWF.

## Benchmark and Settings.
There are two kinds of settings proposed in this field, *disjoint* and *overlapped*. Since *overlapped* is a more realistic setting, we only conduct experiments on this scenario. Nevertheless, the readers are encouraged to test our method on different settings in disjoint scenario and compare them with other methods.
Plus, we call each training on the newly added dataset as a step. Formally, X-Y denotes the continual setting in our experiments, where X denotes the number of classes that we need to train in the first step. In each subsequent learning step, the newly added dataset contains Y classes.

## Dataset Preparation
- PASCAL VOC 2012
```
sh data/download_voc.sh
```
- ADE20K
```
sh data/download_ade.sh
```

## Environment
1. Please intall the environment according to ```environment.yml```.
2. Install [inplace-abn](https://github.com/mapillary/inplace_abn)

## Training
1. Dowload pretrained model from [ResNet-101_iabn](https://github.com/arthurdouillard/CVPR2021_PLOP/releases/download/v1.0/resnet101_iabn_sync.pth.tar) to ```pretrained/```
2. We have prepared some training scripts in ```scripts/```. You can train the model by
```
sh scripts/voc/plop+ours_15-1.sh
```


## Reference
If this work is useful for you, please cite us by:
```
@inproceedings{xiao2023endpoints,
  title={Endpoints Weight Fusion for Class Incremental Semantic Segmentation},
  author={Xiao, Jia-Wen and Zhang, Chang-Bin and Feng, Jiekang and Liu, Xialei and van de Weijer, Joost and Cheng, Ming-Ming},
  booktitle={Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition},
  pages={7204--7213},
  year={2023}
}
```


## Acknowledgement
This code is heavily based on [[MiB]](https://github.com/fcdl94/MiB) and [[PLOP]](https://github.com/arthurdouillard/CVPR2021_PLOP). We appreciate their contributions to this community.
