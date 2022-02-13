clear;clc ##初始化

## X = input("请输入原始矩阵");
load x.txt

[r,c] = size(X);

disp("请输入权重，以单行矩阵表示（默认权重都为1）,0表示使用默认权重");
weight = input("");
if weight == 0;
  weight = ones(1,c);
end

judge = 0;
disp("是否需要正向化，0不需要，1需要（默认为0）");
judge = input("");

##正向化处理
if judge == 1;
  disp("请输入需要正向化的列，用单行矩阵表示");
  positiveX = input("");
  disp("请输入需要正向化的列的类型，0极小型，1中间型，2区间型，用单行矩阵表示");
  typeX = input("");
  
  for i = 1:size(positiveX,2)
    X(:,positiveX(i)) = Positivization(X(:,positiveX(i)),typeX(i),positiveX(i));
  end
end
disp("正向化后矩阵为");
disp(X)

##标准化处理
disp("标准化矩阵为")
Z = X ./ (sum(X .* X) .^ 0.5)

##计算得分
ZP = max(Z);
ZN = min(Z);
DP = zeros(r,1);
DN = zeros(r,1);
score = zeros(r,1);
for i = 1:r
  DP(i) = sum(((ZP - Z(i,:)) .^ 2) .* weight) .^ 0.5;
  DN(i) = sum(((ZN - Z(i,:)) .^ 2) .* weight) .^ 0.5;
  score(i) = DN(i) / (DP(i) + DN(i));
end

##归一化
score = score / sum(score);

disp("最终得分及排名为");
[sortScore,index] = sort(score ,'descend')