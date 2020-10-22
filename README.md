# Weakly-Supervised Aspect-Based Sentiment Analysis via Joint Aspect-Sentiment Topic Embedding； 弱监督Apsect-Based情感分析通过联合Apsect-sentiment主题嵌入

代码和数据用于EMNLP论文Weakly-Supervised Aspect-Based Sentiment Analysis via Joint Aspect-Sentiment Topic Embedding.

## Requirements

* GCC compiler (used to compile the source c file): See the [guide for installing GCC](https://gcc.gnu.org/wiki/InstallingGCC).

## Datasets
我们收集域内语料库进行嵌入训练。
为了进行评估，我们在[Sem-Eval 2015](http://alt.qcri.org/semeval2015/task12/) 和[Sem-Eval 2016](http://alt.qcri.org/semeval2016/task5/)。
我们在此repository中预处理了这些数据集。

## Run the Code

### Using the same datasets as ours
```
bash run_jasen.sh
```
这一步贯穿了从嵌入训练到神经网络蒸馏和模型评估的整个流程。
脚本中的``--dataset`` 用于指定要使用的准备好的数据集（restaurant或laptop）。生成的嵌入文件存储在``${dataset}``下。
每个数据集的预测结果在 ``/datasets/${dataset}/prediction.txt``.

### Preparing your own dataset
在新数据集的``/datasets`` 下创建一个新文件夹。
用于联合主题嵌入训练的域内无标签训练语料库``train.txt`` 是每行是一个文档的格式。用于评估的测试集 ``test.txt`` 具有以下格式：
```
line_id	aspect_label_id	sentiment_label_id	text
```
每个aspect和sentiment的关键字都应在``aspect_w_kw.txt`` 和``senti_w_kw.txt``中列出。
每行指的是一个aspect/sentiment 类别。行顺序应与aspect和sentiment标签ID的顺序一致。可以在准备好的数据集文件夹中找到样本。



