function [chisquare] = chiSquare(hist1, hist2)
	difference = (hist1 - hist2).^2;
	histSum = 1./(hist1 + hist2);
	histSum(isinf(histSum)) = 0;
	chisquare = histSum*difference';
end
