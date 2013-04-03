function displayComments(){
	var FAILED = 'true';
	var disqus_shortname = 'sammidysamwebsite';
	var disqus_url = 'http://sammidysam.github.com{{ page.url }}';
	(function() {
		var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
		dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
		(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
	})();
}