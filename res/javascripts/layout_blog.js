function displayComments(){
	document.write("<div id="disqus_thread"></div>
		<script type="text/javascript">
			var disqus_shortname = 'sammidysamwebsite';
			var disqus_url = 'http://sammidysam.github.com{{ page.url }}';
			var disqus_identifier = '0';
			(function() {
				var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
				dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
				(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
			})();
		</script>
		<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>");
}