package moviedam.debate;

import java.util.List;

public class Analyze {

	public double tf(List<String> doc, String term) {
		double result = 0;
		for (String word : doc) {
			if(term.equalsIgnoreCase(word))
				result++;
		}
		System.out.println("term:"+term+" tf:"+ (1+Math.log(result)));
		return (1+Math.log(result));
	}
	
	public double idf(int docsCount, int docsSize) {
		return (double)docsSize / (1+docsCount);
	}
	
	public double tfIdf(List<String> doc, int docsCount, int docsSize, String term) {
		return tf(doc, term) * idf(docsCount, docsSize);
	}
}
