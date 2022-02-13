function positX = Positivization(X,type,column)
  if type == 0
    disp(["正在对第" num2str(column) "进行正向化，该列是最小型"]);
    positX = min2max(X);
  elseif type == 1
    disp(["正在对第" num2str(column) "进行正向化，该列是中间型，请输入中间值"]);
    value = input("");
    positX = mid2max(X,value);
  elseif type == 2
    disp(["正在对第" num2str(column) "进行正向化，该列是区间型，请输入范围，用单行矩阵表示"]);
    range = input("");
    positX = range2max(X,range);
  else
    disp("类型输入错误");
  end
end