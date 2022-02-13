function positX = mid2max(X,value)
  M = max(abs(X - value));
  positX = 1 - (abs(X - value) ./ M);
end