# dataset directory
# dataset=restaurant
dataset=laptop

# 训练数据文本，一个文档一行
text_file=train.txt

#关键字文本，topic_file1是情感，topic_file2是aspect
topic_file1=senti_w_kw.txt
topic_file2=aspect_w_kw.txt

topic=mix

# 加载 pretrained word2vec embedding
pretrain_emb=word2vec_100.txt

if [ ! -f "$pretrain_emb" ] && [ -f "word2vec_100.zip" ]; then
    echo "Unzipping downloaded pretrained embedding"
    unzip word2vec_100.zip && rm word2vec_100.zip
fi

cd src
make joint
cd ..

# 只做联合训练的
./src/joint -train ./datasets/${dataset}/${text_file} \
	-topic1-name ./datasets/${dataset}/${topic_file1} \
	-topic2-name ./datasets/${dataset}/${topic_file2} \
	-load-emb ${pretrain_emb} \
	-spec ./datasets/${dataset}/emb_${topic}_spec.txt \
	-res ./datasets/${dataset}/res_${topic}.txt -k 10 -expand 1 \
	-word-emb ./datasets/${dataset}/emb_${topic}_w.txt \
	-doc ./datasets/${dataset}/emb_${topic}_d.txt \
	-topic-emb ./datasets/${dataset}/emb_${topic}_t.txt \
	-size 100 -window 5 -negative 5 -sample 1e-3 -min-count 2 \
	-threads 10 -binary 0 -iter 5 -pretrain 2 -global_lambda 2.5

python evaluate.py --dataset datasets/${dataset}



