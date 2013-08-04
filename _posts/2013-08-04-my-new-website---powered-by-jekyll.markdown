---
layout: post
title: My New Website - Powered by Jekyll
type: blog
date: 2013-08-04 11:12:11
---

Welcome to the new sammidysam.github.io!  This blog will explain how this website was set up and why I am now using Jekyll to power my website.

Back in early March, there was a science project I needed to do.  The good thing about this project was that you could do pretty much anything you wanted.  I signed up for doing something with technology, and I was off to making a program.  The program ended up being [Science Bridge Simulator](https://github.com/Sammidysam/ScienceBridgeSimulator).  I used C# for the program, which I had never used before.  The reason behind me using C# for that project was to ensure that it would run well on my school's computers, which with Java I was not sure how well it would run (I think that the school computers still use Java 6 - filthy!).  Also, C# seemed like a complete clone of Java, so I had no reason not to try it out.

In the end, C# worked out very nicely.  I liked that I could compile it into an executable file which would work well on any computer.  My actual program created for the project worked fine, but a lot of flaws were left in the code that would make it hard to use in the future.  Nonetheless, it worked fine on Windows.  I brought it to school and tested it there, and it worked well.  I never tested it with the school's [SMART Boards](http://smarttech.com/smartboard) until I was presenting it, and for some odd reason the mouse click signal was not sent when the SMART Board was used.  It was sent when a mouse was used, though.  Because of that bug my presentation was dampered a bit, but it was still very impressive in the end.  I used the bridge simulator as a way of showing examples of how much bridges could hold.  In the future, I may improve the application to allow it to run better on the Mono framework and fix some silly stuff I did inside the program.  I should also fix the style to make it not look horrible.

I really liked C# after making that program, so I decided to make some libraries with C#.  It was the first time I had ever made libraries.  My first library was [File Helper](https://github.com/Sammidysam/FileHelper), which just added some convenience methods wrapping C#'s file utilities.  This library's style was way better than Science Bridge Simulator's style.  After making File Helper, I wanted to make a library for automatically updating games.  I had a few games in development, and I thought that it would be really cool to have them automatically update so that the people testing the games didn't have to manually update a lot.  I decided to use C# for this project.  The library that was the result is called [Game Updater](https://github.com/Sammidysam/GameUpdater).  It has since been starred by [Sébastien Rombauts](https://github.com/SRombauts), who has made a similar library called [Updater](https://github.com/SRombauts/Updater), which I assume was based off of my library.  When making my library, I needed a place to store files in order to test my library, and I found out about GitHub Pages.  I set up a website, sammidysam.github.com at the time, and got to work making the library.  That is how this website was born.  Below is the old design for my website, back when it was only using HTML and CSS.

![The Old Design](/img/website.png)

Later, around May, my friend [Kristofer Rye](https://github.com/four04) made his website, [four04.tk](http://four04.tk/), which uses Ruby on Rails.  It looked great, so I thought that I should look into Ruby on Rails.  Off and on throughout the past three months I have, and I really like it.  It made web development way more fun than plain HTML and you could do so much with it.  The problem that grew to make me move away from Rails was that hosting the website using Rails was not as easy as with HTML.  With HTML, you could get a GitHub Pages website and provided would be free hosting and seemingly infinite space for files.  It was so convenient.  With Ruby on Rails, you would need to get a Heroku website which has limits.  This seemed to me to make the process of getting Heroku set up right not worth the power of Rails, especially with how small this website is.  Because of that, I wanted to look back to see if there were any dynamic website engines similar to Rails that could work with GitHub Pages.  All I needed was layouts and I was good.

I found Jekyll, and here we are today!  Jekyll is great.  Jekyll has done almost everything I wanted it to do by default, and impressively at that.  After installing the gem jekyll, I ran `jekyll new sammidysam.github.io` and then I had most of the website set up for me.  I only had to do some inner work to make it work right.  What I needed to do primarily is get project pages set up.  By default, Jekyll does not have support for for loops involving projects.  This is stupid; Jekyll should have a `_projects` directory for project pages.  There are plugins for Jekyll that provide for just that, but I wanted GitHub Pages to generate my site for me, and no plugins can be used if GitHub Pages will generate the site.

I managed to solve this problem, however.  In Jekyll, each page has some variables.  I decided that by adding a variable `type` to each blog post I could make certain blog posts act as blog posts and other blog posts act as project pages.  It works great.  Now to list my blog pages, I simply do

{% highlight html %}
  {% raw %}
<ul class="posts">
  {% for post in site.posts %}
    {% if post.type == "blog" %}
      <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">
{{ post.title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>
  {% endraw %}
{% endhighlight %}

For project pages, it is similar, except I change what string is being asked for in the type variable.  This little hack I have found extremely helpful for dealing with project pages, as GitHub Pages will still build my website because I am using no plugins.

Besides adding support for project pages, I have made a Ruby script that allows you to easily add new pages to your website.  You can see it [here](https://github.com/Sammidysam/sammidysam.github.io/blob/master/newpage.rb).  It seems to be very similar to the rake commands jekyll-bootstrap provides.  I decided to make it myself to customize how it does things.  In the future I plan to rename the file from `newpage.rb` to `pages.rb` and then allow more manipulation of pages besides just creating new ones from it.

Much of my website still needs to be built.  The home page is not finished with welcome and about the website text, no project pages have been given content, no downloads are being hosted yet, and some more little things need fixing.  Nonetheless, I introduce to you my new website and I hope you enjoyed reading the history of how it came to be.
