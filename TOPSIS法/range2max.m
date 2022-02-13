function positX = range2max(X,range)
  M = max(range(1) - min(X), max(X) - range(2));
  positX = zeros(size(X, 1), 1); ##初始化positX
  for i = 1:size(X,1)
    if X(i) < range(1)
      positX(i) = 1 - (range(1) -X(i)) / M;
    elseif X(i) > range(2)
      positX(i) = 1 - (X(i) - range(2)) / M;
    else
      positX(i) = 1;
    end
  end
end