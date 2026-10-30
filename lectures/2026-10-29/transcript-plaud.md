00:00:04 Daniel Chen
Hello.

00:00:26 Daniel Chen
Hello.

00:00:33 Speaker 2
Hello. Yes.

00:00:35 Daniel Chen
Before we get started, does anyone have any questions about anything related to the course?

00:00:49 Speaker 2
Hold on.

00:00:54 Daniel Chen
Someone wrote something. Give me one sec.

00:01:06 Daniel Chen
Cool.

00:01:07 Daniel Chen
So I'll talk through some stuff today. I will provide links to everything in the Zoom chat in a little bit.

00:01:17 Daniel Chen
As folks have seen, or hopefully you've seen, everything is recorded. You'll see the Zoom recordings. One of the things that I've been doing.

00:01:27 Daniel Chen
So here's the main repository link to everything that we've been working on during these office hours. The plan is next week. I was going to go over how you might install and run some of this stuff on your own computer.

00:01:46 Daniel Chen
So next week will be a little bit shorter, and we can try stuff out. That's the goal.

00:01:53 Daniel Chen
And then the office hours after, since it is the very last office hour for this course, that would be. I'm not planning to lecture on anything per se.

00:02:06 Daniel Chen
But that's really the open office hours for any last minute questions.

00:02:14 Daniel Chen
We could

00:02:18 Daniel Chen
We can do. We can use all of the stuff that we set up this week, and if you have questions about other things that you can do with code that might help you supplement some of the stuff we've been working on in this class. I know that this micro-credential was purposely written where we don't expect you to actually code or do anything. That's why all of the code or all of the homework assignments are very like.

00:02:52 Daniel Chen
I know it's low code. I think it's actually zero code. If I'm remembering correctly, I don't think we actually have you do any code. Even with the Looker stuff, it's mostly thinking about the visualizations.

00:03:04 Daniel Chen
But if you have any questions about what this might look like, I teach everything on a code first basis. This is just a little bit of me rubbing off on how to spend a lot of this office hour. Otherwise, it just ends up being an hour of me sitting around waiting for people to ask questions. That's sort of how I've approached adding more stuff.

00:03:31 Daniel Chen
So this week we'll talk about visualizations. That'll map pretty well to the stuff on Looker, except Looker, all the things that we will type or I'll show you in code are really drag and drop features in the UI. That's where those two things are related. Next week I'll. If you're in that website that I just put into chat, which is what you're looking at right now

00:04:03 Daniel Chen
I believe if you have a GitHub account, which is what I talked about last week, and you click on the green code button and you click on like, there's two tabs here. If you click on the GitHub Codespaces tab, you'll get a big green button. If you never opened one before, hopefully that shows up that way.

00:04:19 Daniel Chen
If it doesn't, there's a fork button, and then essentially that. It is going to copy all of the code here into your own account, and then you can open up a GitHub Codespaces. But I don't think that's the case. At least no one has really told me that was the problem.

00:04:35 Daniel Chen
So when you click on this little GitHub Codespaces, give it about ten minutes, and it will eventually.

00:04:40 Daniel Chen
All it's doing is installing, downloading the computer that we are working with, and if you do it correctly, you will eventually get a.

00:04:53 Daniel Chen
This is everything we're going to talk about today. You will eventually get a page that looks like this.

00:04:59 Daniel Chen
And this is the coding interface that we've been working with. I've been coding, putting all of the code here. So last week's code is in this. I did not put in last week's code. I need to put in last week's code. I guess I forgot to upload that.

00:05:17 Daniel Chen
Last week's code you'll see it as one dash tidy. R I guess I owe you that, and then today we'll talk about another file called two dash visualizations and I'll make sure all of those things are there. The other thing that I've been doing

00:05:31 Daniel Chen
It's been these office hour sessions are recorded on Zoom so you can always play back the video if you're missing some visual component.

00:05:41 Daniel Chen
But what I have also been doing is taking the audio portions of the lecture

00:05:49 Daniel Chen
And there's a running transcript, text transcript of the lecture

00:05:55 Daniel Chen
And what I have been doing is turning those text transcripts into LLMs.

00:06:03 Daniel Chen
Or an AI model. One is Claude, and these two are local models that don't really run on a machine I have at home.

00:06:13 Daniel Chen
And they're taking that text transcript and trying to create a summary document of everything that we talked about. So you have something that is less of a transcript but more like a detailed summary.

00:06:29 Daniel Chen
What my master's students have told me is the way they've done it, use this type of

00:06:36 Daniel Chen
Information was they glance through the main headers just to see if they understand the concepts. But yes, there's a hand from Aldo.

00:06:45 Speaker 3
Thanks Daniel. It's just maybe a bit of a random question, but I'm also running local models, so it's mostly just curiosity. So you're running a 27 billion parameter model. How much RAM do you have for your local LLM setup?

00:06:59 Daniel Chen
My local LLM setup. I have a lot.

00:07:03 Daniel Chen
Sure, I have what is. Total, I have 120 something.

00:07:13 Daniel Chen
What whatever the multiple of that is, the 27B model takes up.

00:07:21 Daniel Chen
Hold on, I have an answer to that. The 27B model takes up 41 gigs.

00:07:25 Speaker 3
Because I have 48, and I'm struggling with the ones that start to hit thirty medium. That's why I was curious. Thanks.

00:07:31 Daniel Chen
But that's why. Now we're talking about LLM stuff, and that's why I'm running this model. I think I was some of my students. I've been trying to run an even smaller model, something that you can actually fit on a laptop.

00:07:49 Daniel Chen
And I'm trying to work to see the progress for that. But since we're talking about LLMs as well, in this folder, in this directory, in the lectures directory.

00:08:00 Daniel Chen
You'll see a prompt notes file, and this is exactly how I'm telling the model how to create those notes that you've seen. So every time I take the I tell it you're going to have a transcript file.

00:08:14 Daniel Chen
Depending on what we have, you might have a code file or a history file from the actual code that gets run. Sometimes I forget to do that, and sometimes I don't. Then I'm here with the general summary format I want you to use. Summarize things here, like the rules that I want you to follow. How do you work with both the transcript and the code? This is literally the instructions I feed the model to create these summaries. I'm playing a lot more with local models because I'm curious if I'm giving you all of this detailed input.

00:08:54 Daniel Chen
I'm hoping that the smaller models that run on your laptop can actually generate very decent summaries if I'm giving you a lot of good input for things.

00:09:04 Daniel Chen
But that's sort of what's happening under the hood. I'm just trying that across all of my courses, and that's a little bit about how this stuff is working throughout the week.

00:09:20 Daniel Chen
Today we are talking about visualizations. I realize that in the past the examples I've used don't have a medical data set. This was part of my dissertation project. It's on my list of things to do to make it prettier and write out more of the things. There is a chapter on visualizations. We'll go through it.

00:09:51 Daniel Chen
We'll literally just talk through this chapter, and it uses a R package called Medical Data. This was curated by Peter Higgins. I think he is in the University of Michigan. He's a gastroenterologist at Michigan, and he curated this data set. We'll be using this blood storage dataset that he put together.

00:10:20 Daniel Chen
It is about the biochemical cancer recurrence after people who have undergone radical prostatectomy.

00:10:30 Daniel Chen
Removing the prostate.

00:10:33 Daniel Chen
Not prostate.

00:10:34 Speaker 2
Is it prostate?

00:10:40 Daniel Chen
Yes. Is that right? Yes. I think that's right. Someone please correct me, but it's removing that along with the surrounding tissue, hence the radical part. And there is a couple of blood markers. I have.

00:10:58 Daniel Chen
It's been a while since I've actually worked in a clinical setting, but there are a couple of things that we can talk through for visualizations. We are literally just going to go through all of the code here. I bring this reference up as well, because sort of down here. We're in Chapter Seven of this textbook right now. When you take the next micro-credential class, I believe that is the machine learning course or the machine learning stuff.

00:11:29 Daniel Chen
I think you go through logistic regression if I remember correctly. I know you go through something else called k-means for clustering. I don't think this particular textbook goes through clustering.

00:11:42 Daniel Chen
It doesn't. But there are some

00:11:46 Daniel Chen
Modeling chapters in here. If you want to extend what we've been working on in these office hours to what you might be working on in later courses, feel free to use it. All the code is there. Again, if you're using this code space

00:12:02 Daniel Chen
You do have access to Copilot.

00:12:07 Daniel Chen
The last I read, you get 1,500 like.

00:12:11 Daniel Chen
1,500 questions you can ask per month

00:12:15 Daniel Chen
And right now it's set to auto, so it tries to figure out the best or cheapest model for you to run. But you do get access to some of the more recent and newer AI models. That's sort of why I have this set up. I'm also test driving this GitHub Codespaces setup in this micro-credential for the first time.

00:12:41 Daniel Chen
See how we can use some of these things without having you install it locally, so you can always run things on your computer.

00:12:51 Daniel Chen
There's a couple of things. I already ran through all of the code. I was nervous about things not working properly. I already provided all of the code, but I'll show you. We'll talk about all of the results as we go.

00:13:08 Daniel Chen
So the first thing that we're going to do is there's a package called medical data

00:13:13 Daniel Chen
And I will update this for next week, but right now you do not have this installed. So what you end up having to do is if you try to run this, you'll probably get a.

00:13:30 Daniel Chen
Nope, never mind.

00:13:36 Daniel Chen
If you run this, you might get a message that says "Medical Data Package not found." So what you will end up doing is you'll run a function called install. Packages.

00:13:46 Daniel Chen
Open parenthesis, a quote, and medical data. You'll run this particular function.

00:13:53 Daniel Chen
And what that will do is it'll install and download all the datasets that we need for this package, and then these two functions that we've been using will work.

00:14:05 Daniel Chen
Selecting the code I want, and then on a Mac I've been using Command+Enter, and on Windows I believe that should be Control+Enter to run that code down here.

00:14:20 Daniel Chen
And the first thing that we're going to do, so this essentially saying from the medical data package that we have, there's a data set called blood storage. Please assign that to a variable called blood. And we will look at this particular data set.

00:14:42 Daniel Chen
This is the data set that we'll be working with right now, which is this radical prostatectomy data set. Looking at the goal of this, which is biochemical cancer recurrence. We're not going to be using models to predict this, although this made for that type of problem, that prediction problem.

00:15:03 Daniel Chen
So here's our dataset. Down here, we have age groups, median age. We have the actual age. We have a couple biochemical markers, and we have time to reoccurrence. This is if you've done any type of health analytics problem before, time to reoccurrence. That's a survival analysis problem, and I believe I actually use that example in my textbook.

00:15:30 Daniel Chen
And then there's a column called recurrence, so that's one for yes, that did happen, zero for no, that didn't happen. You can also use this as a logistic regression problem where you're trying to look at yes/no or binary outcomes or things that have two possible outcomes associated with them.

00:15:53 Daniel Chen
So a little bit of review.

00:15:56 Daniel Chen
This is a tidy data set because if we look at the definitions that we saw last week, each column represents one variable. Each column, there doesn't seem to be a pattern associated with it. If we look at the individual cells

00:16:15 Daniel Chen
Everything is really only recording one thing.

00:16:18 Daniel Chen
There's no color coding. Each column is only one variable, and each row is one observation, either through time because this is sensor data.

00:16:29 Daniel Chen
This might be for an individual person, I believe, but sometimes each row ends up being like a timestamp. In this case, each row does represent one individual person.

00:16:42 Daniel Chen
So our data set is tidy, and that's the stuff that we talked about last week.

00:16:46 Daniel Chen
And if it's tidy, and if we're looking at recurrence, so recurrence is like one yes, there was a positive cancer marker, zero no, there wasn't. We might want to know how many people are in each group.

00:17:00 Daniel Chen
And so we can say for each value of recurrence, please count those values. There's another way you can do it as well. There's a count function that can give you the count. For the recurrence value for zero, there's 262 observations or people in there, and then for those who have the actual cancer biochemical cancer recurrence, there's 54 people.

00:17:26 Daniel Chen
So that's the frequency count of what's happening. If we were really thinking about machine learning and fitting models and all of this, all of that

00:17:36 Daniel Chen
This will sort of raise a flag because the groups that we're trying to predict on zero or one

00:17:44 Daniel Chen
It's very imbalanced, meaning that there are about 4 times more people in one group than the other.

00:17:50 Daniel Chen
And that could be bad depending on how much error your model is doing. That could be something that's bad and we'll talk through. You can see it through a table, but you can also see these things when you are visualizing.

00:18:08 Daniel Chen
The library that we're going to use to make plots is going to be called ggplot2. It stands for Grammar of Graphics.

00:18:17 Daniel Chen
This particular package, what in R was written by Hadley Wickham, and the concept of Grammar of Graphics did not come from him. But essentially, it is a way where you can describe any arbitrary visualization, and it's one of the more powerful features of R. For me personally, it's the reason why I stuck with R, doing a lot of data processing work. Even though Python is a very popular language for that stuff as well.

00:18:49 Daniel Chen
But for me, every time I needed to make a figure, I always ended up doing stuff back in R to make these types of visualizations.

00:19:00 Daniel Chen
So the way ggplot2 works is there's a function called ggplot2, and then we have to give it the data set that we want the plot.

00:19:09 Daniel Chen
So we can say ggplot2 data equals blood, and you can see here I got a big gray square.

00:19:16 Daniel Chen
So if we go back to the textbook, there's a couple of things we need to know. When we are talking about ggplot2 and thinking about data

00:19:25 Daniel Chen
We need to first know what type of information is being stored in our dataset.

00:19:33 Daniel Chen
Is it continuous? Like, is it a number that you know essentially? Like, does it have decimal points in it? That is a continuous variable, or is it a discrete variable? Like, do they only come into steps? Like again, if you're counting people, like there's no such thing as half a person, for example. Like if I'm asking how many children you have, you're not really going to say one and a half kids. That's the first thing.

00:20:04 Daniel Chen
If it's a number, you have to see if it's a continuous number or a discrete number.

00:20:11 Daniel Chen
But then

00:20:13 Daniel Chen
You can also have what are known as nominal variables, or things that are essentially like categories.

00:20:20 Daniel Chen
So you have

00:20:21 Speaker 2
Sorry

00:20:23 Daniel Chen
Not nominal. You have categorical variables, and there's different ways categorical variables can be stored. They're either nominal, meaning that they're just different categories. There's no natural order to them. So one example would be

00:20:43 Daniel Chen
Your favorite sport, right? The sport that you play

00:20:47 Daniel Chen
That would be an example of a nominal variable. Even does not na is also a var of an appropriate variable category in that sense too. It's a category, but there's no order. One is not better than the other. Although that becomes an opinion. Running is not necessarily better than swimming. They're just different groups.

00:21:09 Daniel Chen
And then you have ordinal variables, which is No, there is an actual order to this. You can see here, you'll see Likert scales, or how happy are you? Those are typically ordinal variables because there's an order.

00:21:26 Daniel Chen
Disease progressions are typically recorded in.

00:21:30 Speaker 2
I'm blanking on the word.

00:21:37 Daniel Chen
It's not level.

00:21:40 Daniel Chen
Although.

00:21:41 Daniel Chen
Is that the right word?

00:21:43 Daniel Chen
Stage, stages. Diseases sometimes are reported in stages, so you have stage one, two, three, four for a particular disease progression. That is an example of an ordinal variable. There are

00:21:55 Daniel Chen
There's an order to it.

00:21:56 Daniel Chen
And then a lot of variables, or especially when you

00:22:02 Daniel Chen
What I like to do when I end up doing a very quick analysis at my very first analysis is to take these categories and turn them into binary categories, like yes or no, with only two options to choose from.

00:22:18 Daniel Chen
Binary is a special type of categorical variable where there's only two categories, and there are a lot more statistical methods that work with binary, or they're a lot easier to work with or understand and teach.

00:22:32 Daniel Chen
You typically learn about binary categories first. The textbook that I have.

00:22:41 Daniel Chen
I believe we do that. So the very first model that we talk about is logistic regression, which is how you model binary variables.

00:22:53 Daniel Chen
So that's the first thing that we have to understand.

00:22:57 Daniel Chen
And why did we get a blank square?

00:23:05 Daniel Chen
From the grammar of graphics, this figure is essentially how it works. There are different layers, and then we use this grammar to talk about which. How do we add different things to the layer? For the most part, we're really just going to be talking about the first couple. Actually, we'll talk about almost all of them, except for coordinates and theme. We'll essentially talk about all of these different layers we can add to the plot.

00:23:31 Daniel Chen
So back to our actual dataset. That very first layer, we have to go and specify the actual data, and so we get a gray square because all we've done is here's some data. We even didn't provide what variable we want to work with

00:23:47 Daniel Chen
So it's just trying to draw something, and it drew a gray square for us.

00:23:52 Daniel Chen
The next thing, if I'm really curious about this table of results that we just calculated, I'm looking at the recurrence column.

00:24:01 Daniel Chen
And so there is another layer called the aesthetic mapping.

00:24:05 Daniel Chen
That's the technical term in here.

00:24:08 Daniel Chen
And the aesthetic mapping is essentially saying, "Hey, you gave me a data set. What is the column you want me to work with?" And that ties back into a lot of stuff we talked about last week because our data needs to be tidy so we can point to an actual column. So that's why you need to think about how to make your data clean.

00:24:27 Daniel Chen
Tidy data is a really important concept. It defines how you clean your data.

00:24:32 Daniel Chen
And now it's showing up because now you need clean data to perform or make a figure, and it goes even further because now you need also the same clean data typically to go and fit a model because you have to point to particular columns.

00:24:45 Daniel Chen
So we can say, hey, I actually want to look at the recurrence column.

00:24:51 Daniel Chen
And so you can see we get a little something a little bit different. It's no longer just a gray square anymore.

00:24:57 Daniel Chen
And it's giving us the range for recurrence, and we know the range for recurrence is just zero and one. So it's trying its best. It's saying the only possible values are zero and one, and now it's going to make the axes fit zero and one.

00:25:12 Daniel Chen
But that's great. We haven't told it what to draw. The next layer we have to add is called the geom, the geometry layer.

00:25:21 Daniel Chen
And the geometry layer is essentially saying there's another layer that we literally use the plus.

00:25:29 Daniel Chen
Symbol for

00:25:31 Daniel Chen
And the geometry layer essentially says, "What do you want drawn on the screen?"

00:25:37 Daniel Chen
So I can say "geom_" underscore, and all of the geometry layers begin with "geom_" underscore, and we can say, "I want you to draw bars" or "for a bar graph."

00:25:46 Daniel Chen
And those three things are all that it needs. I want to draw a bar graph.

00:25:53 Daniel Chen
I'm looking at the recurrence. Variable and that variable is coming from the blood dataset that we are working.

00:26:03 Daniel Chen
Here's a bar for zero and here's a bar for one. And if you're giving it the raw columns of data

00:26:13 Daniel Chen
It will do the frequency count for you. So you can see we have zero, one hundred, two hundred. We're not at three hundred yet, but we're about two fifty something maybe. A little bit more than 250, so that's the height of the count for recurrence of zero, and that matches with the frequency table that we have right here.

00:26:41 Daniel Chen
And then we have something a little bit more than 50 for one, and that makes sense. We have an actual count of 54.

00:26:48 Daniel Chen
So that's essentially the basic part of ggplot.

00:26:52 Daniel Chen
Give it a dataset. Give it an aesthetic mapping. The aesthetic mapping allows you to specify where in the column

00:27:02 Daniel Chen
Which column to use. I want to say X is going to be for recurrence, and then I want to draw bar. You can also say instead of X, I want this to be Y, and you'll get bars the other way. And that's one of the easier ways you can make that flip as well.

00:27:20 Daniel Chen
So.

00:27:22 Daniel Chen
One of the things that I've done in the just before is sometimes what you end up doing is you've already pre-calculated these numbers. So instead of having R say, "Hey, I want you to take this recurrence column, you go manually calculate the height, calculate the frequency, draw the height of the bar," you might have already had this stuff pre-calculated.

00:27:46 Daniel Chen
And so there's another way you can rewrite this function.

00:27:52 Daniel Chen
Where I'm going to give it a different data set this time. I'm the recurrence frequency. This is the column that we have, and I'm going to say this data set has two columns: one for recurrence, one for count.

00:28:05 Daniel Chen
I want x on the recurrence. I want count on the y-axis. So I'm using this data set, and essentially I'm saying stat equals identity, meaning I don't actually want R and ggplot to calculate how many unique values are there. I've already done it, so the identity is please just return the number that I've given you.

00:28:31 Daniel Chen
And so this is another way where we can say hey, and you can say the figure didn't change because the code has changed because we're using a different data set

00:28:42 Daniel Chen
And these are the columns that we're using. We're still making a bar graph, and there's this little extra piece around what you're typing.

00:28:51 Daniel Chen
So this is how you navigate around what the code sees and you can again

00:28:57 Daniel Chen
If you have access to a model. So in this case, we have access to Copilot.

00:29:03 Daniel Chen
You can ask it, "Can you explain what is happening in this code?" Right, and you can paste that, and it's going to go and.

00:29:18 Daniel Chen
Use one of the models that it has access to. So you can see here, it's picking GPT-6 Luna, which is one of the OpenAI models. Occasionally, I get one of the Anthropic models, and occasionally I get some of the other models as well. This is kind of—it's not totally random, but it's not you're sometimes get different things.

00:29:39 Daniel Chen
And you can see here, it's saying I'm creating a bar chart. This part is using this particular data set. It's using recurrence on the horizontal axis, count on the vertical axis. That's what this code is doing. I'm going to add another layer, and I'm going to draw a bar graph. The height's already supplied, and then it actually gives me this. Without identity, it would count the rows by default. So it would count the rows, meaning there's only one value of zero and one value of one.

00:30:10 Daniel Chen
So I'll get two bars with a count of one.

00:30:16 Daniel Chen
So that's one of the nice things of using these particular models.

00:30:20 Speaker 2
What I've done

00:30:24 Daniel Chen
You can use it outside of this coding interface, but at the end we can see we can actually have it write some actual code and visualizations for us as well.

00:30:35 Daniel Chen
Okay.

00:30:37 Daniel Chen
One of the things here that I am trying to show you is because of the way we can move layers around.

00:30:47 Daniel Chen
I can say my base layer just has the data, but what draws the bar, I have different. I want to specify the x and y values in the bar drawing layer.

00:31:01 Daniel Chen
It will do the same thing. If you look at this code, you might think to yourself, does this really matter? It doesn't matter.

00:31:10 Daniel Chen
All I'm trying to get at is you can actually have you can essentially overlay different visualizations on top of one another, based off of the same data set, and you'll see an example of that being used in play.

00:31:26 Daniel Chen
But this also allows you to say, hey, you can actually have totally different data sets overlapped on top of one another. Sometimes you might need that.

00:31:41 Daniel Chen
I think I have an example.

00:31:44 Daniel Chen
Hopefully, they haven't changed it on their website.

00:31:48 Daniel Chen
Oh

00:31:54 Daniel Chen
Here's an example of a data set. It's in Python, but it's the ggplot version, and you can see here. I'm running ggplot. I'm saying the aesthetic mapping is going to be one of the columns called bill length. And I'm adding two different histograms with two different data sets associated with it, and each data set will have a different color.

00:32:18 Daniel Chen
And what this is essentially doing is there's a baseline data set

00:32:22 Daniel Chen
And then there's a highlighted histogram on top. That's one of the things you can do with ggplot because you're able to literally overlay figures on top of one another.

00:32:36 Daniel Chen
So that's some of the things you can do.

00:32:38 Daniel Chen
I'm mentioning that because with a lot of the tools available to you for AI and all of that, learning and manually writing this code is now something that's a lot easier to work with.

00:32:54 Daniel Chen
Hopefully

00:32:56 Daniel Chen
Especially now with this particular course, hopefully you're getting a little bit of you're seeing figures or thinking about figures for the first time. You're seeing code and you're able to see what is actually possible.

00:33:10 Daniel Chen
And then you can always prompt the AI for making that happen and doing things like aesthetic mapping.

00:33:19 Daniel Chen
Making a bar graph

00:33:20 Daniel Chen
Doing things as an overlay using different datasets. Those are all keywords to help get you a better answer.

00:33:27 Daniel Chen
And so here's another example where I'm saying, hey, I'm just going to start with an empty baseline, and then all of the figure is going to need to be specified in a geom bar layer.

00:33:39 Daniel Chen
Again

00:33:41 Daniel Chen
Doing all the same thing, but it's just moving which part of the layering system that you're working with. So the next thing, that's just how ggplot works.

00:33:53 Daniel Chen
This entire layering system. You can specify the data in the data layer. You can specify data in the mapping layer. That's most of the time. That's where you're going to be specifying stuff. And we've just talked about data mapping and geometries.

00:34:10 Daniel Chen
So we earlier talked about the different types of variables that can exist in your dataset

00:34:19 Daniel Chen
And so when you're thinking about visualizations, there's a couple of things you want to think about. The first thing you're going to think about is how many variables you want to look at.

00:34:27 Daniel Chen
So here I have a section called univariate. When we're looking at one variable, you ask yourself the question: Is it a number or is it a category? And if it's a number, is it just a number with a decimal, or do they have to be whole numbers? Or if it's a categorical number, think about the ordinal, nominal, and binary.

00:34:48 Daniel Chen
Feature of that variable.

00:34:53 Daniel Chen
So in this case, if we're looking at the blood data and I want to look at age.

00:34:59 Daniel Chen
I believe in this data set, age is reported in whole numbers. You could do this as a

00:35:06 Daniel Chen
A whole number value, but age is sometimes most of the time people think about age as a continuous variable.

00:35:14 Daniel Chen
And so when you're working with continuous variables

00:35:19 Daniel Chen
The main figure that you're going to be working or thinking about is a histogram.

00:35:24 Daniel Chen
In this particular case, I believe geom bar will also make sense.

00:35:32 Daniel Chen
Except the issue with geom_bar is it's counting each unique value of age and giving you a frequency count of that, which is totally fine.

00:35:42 Daniel Chen
The histogram allows you to create age ranges. I'm not doing any more data processing, but you might care about having age collected in whole numbers, but actually wanting the frequency counts of age 40 to 45, 46 to 50.

00:36:02 Daniel Chen
51 to 55, 56 to 60

00:36:07 Daniel Chen
Something like that. Then you're essentially grouping those numbers together, and that's what a histogram is doing for you with your numbers. It's essentially creating ranges, not just summing up the ranges, not just unique values.

00:36:27 Daniel Chen
And so again, here's our data set. Here's the variable we want to work with. Here's the geometry or the thing that we want to plot. So here's the part that's going to be different in every single visualization library that you work with.

00:36:41 Daniel Chen
In bar graphs in ggplot, they are called geom_bar. Sometimes I think in looquer they're just called bar. Sometimes they're called bar graph.

00:36:50 Daniel Chen
In Excel, it's called something bar-related.

00:36:54 Daniel Chen
So you're going to have to always know the general.

00:37:01 Daniel Chen
Function or tool that's being called for that particular visualization. Sogeombar geom_bar makes bar graphs geomhistogram, geom_histogram makes histograms, and with histograms you have the ability to change the width of the bin.

00:37:16 Daniel Chen
So each function has the ability to fine tune or tweak it a little bit, and histograms allow you to change the bin width of something.

00:37:26 Daniel Chen
So that's one variable we looked at.

00:37:32 Daniel Chen
One variable when it's a categorical variable or a discrete variable, a numeric discrete variable, so that's a bar graph. This is a continuous variable we're looking at histograms. Now let's think about what happens when we are looking at two variables. We go through the same thought process: how many variables do I want to look at?

00:38:01 Daniel Chen
Before we were looking at one, now we're looking at two.

00:38:05 Daniel Chen
And we ask ourselves the same question: Are we for those for each of those variables

00:38:10 Daniel Chen
Is it continuous

00:38:12 Daniel Chen
Or is it categorical, or are they one of them only continuous, or are they both continuous, or are they both categorical? There's every single combination, and there's typically a visualization that works for all of that. But that's how you start to narrow down what is the proper way to visualize that.

00:38:32 Daniel Chen
That data, and that's usually a good first start. Sometimes you might end up in weird scenarios where I'm trying to visualize three or four things at the same time, and sometimes you have to get a little bit creative. But this is sort of the thought process of getting into the first area where you can look at your data.

00:38:51 Daniel Chen
So in this particular case, we're looking at age on the y-axis, and total volume is going to be on the x-axis.

00:39:02 Daniel Chen
And this is an example of using a discrete. I believe this discrete.

00:39:13 Daniel Chen
A discrete variable is coded as a number, but it's really a category of sorts.

00:39:24 Daniel Chen
And this is another. And we're trying to look at that over a continuous variable. So whenever you have one of them is categorical. One of them is continuous. You might want to think about something like a box plot

00:39:38 Daniel Chen
And so that's great. We have a box plot.

00:39:42 Daniel Chen
This line represents the median. We have the 25, 50, 75 percent quartiles. We have the interquartile range, and then all of these dots are anything outside of the formula that uses the interquartile range to give you a sense of if you have outliers in your data.

00:40:04 Daniel Chen
So this is a box plot. It is a very traditional visualization used in statistics.

00:40:12 Daniel Chen
But there's a problem in this visualization, and it is because if we look at total volume, t_vol

00:40:26 Daniel Chen
You can see it is. It has values of one, two, and three, and it's really like a category, or it's really a whole number, not just a continuous variable.

00:40:39 Daniel Chen
So we need to actually turn it into a categorical variable. In R, or in a lot of statistics speak, a categorical variable you might hear it as a factor.

00:40:50 Daniel Chen
I don't know why that's just the language.

00:40:55 Daniel Chen
Statisticians have used and R is built by statisticians. There's a lot of language coming from the statistics world.

00:41:03 Daniel Chen
So what this is doing is it's the same code to use the blood data set, creating a box plot. Our x variable is going to be t_vol. Our y variable is going to be age. But what we're doing is, this particular column, please treat this like a categorical variable, even though it's a number. I want you to treat it as a categorical variable.

00:41:24 Daniel Chen
If we run this

00:41:26 Daniel Chen
That will say you have t_vol

00:41:28 Daniel Chen
Total volume values of one, two, three, and missing, and now we are getting the proper distribution of age across each of those categories. This is something you'll use a lot, where maybe there's a category or a stage of a disease you care about. You'll have stage one, two, three, and four, and then maybe age.

00:41:53 Daniel Chen
Survival rates on the y-axis, and the lower stage diseases people are living longer, and then when you get to a more serious case of the disease, your probability of survival is lower, similar to this. You don't see any difference here, but it could be people with higher stages would be older because that's typically something that's happening with people when they're older. So that is one way you can visualize that particular piece of information.

00:42:25 Daniel Chen
And this is an example of something that's really common where you have something that is a number, but you don't want to actually treat it like a continuous number

00:42:34 Daniel Chen
And so you have to manually convert it into a factor. That's what's happening there.

00:42:41 Daniel Chen
And that's great, but there's another type of figure called a violin plot.

00:42:51 Daniel Chen
And a violin plot is actually I ran too much. A violin plot. If we look at a violin plot

00:43:00 Daniel Chen
It is a histogram that's mirrored on two sides.

00:43:04 Daniel Chen
And all this is doing is, I know you're just looking at all of the age data, but sometimes distributions are hard to see, like the shape, like where is the bulk of the data?

00:43:15 Daniel Chen
It's hard to see in a box plot.

00:43:17 Daniel Chen
And so violin plot is a different type of visualization. Instead of just putting in the box plot pieces

00:43:27 Daniel Chen
I'm just going to show you the distribution, which is the histogram that's mirrored for that particular numeric variable.

00:43:38 Daniel Chen
And this is an example where we're really using the ggplot layering system. We're saying, hey, we have a common data set. But I want you to overlay two different things on the screen, and here's the x and y values I want to draw.

00:43:53 Daniel Chen
And I'm using different plots. Here you can see, I have a violin plot, but I'm also drawing the points on top. We can actually combine the two previous plots as well, and you can say instead of points, I want to draw the box plot on top of the violin plot. This doesn't look as great. But you can see, we're just slop, just drawing the box plot right on top.

00:44:22 Daniel Chen
And that's this is sort of hinting at the sort of flexibility that ggplot is allowing, allows is giving you

00:44:31 Daniel Chen
Drawing points on top of drawing one set of data on top of another set of data. It ends up being a little bit more difficult in a lot of other tools.

00:44:41 Daniel Chen
So why did I draw the points? It's to show trying to give another piece of visual cue of where all of the age values lie in our data.

00:44:57 Daniel Chen
But the problem with point data is right here where my mouse is

00:45:02 Daniel Chen
It could be really overplotted, right? Like I can have a thousand or not really a thousand in this case, but I can have a lot of sixty-five year olds, but I'm going to have the point the same point right on top of one another.

00:45:14 Daniel Chen
So there's another type of point called geom_jitter

00:45:20 Daniel Chen
And all this is doing is, I see your point, but instead of drawing it exactly where the data is, I'm just going to pick a random width within this group and just move the point from side to side.

00:45:32 Daniel Chen
So that's called a jitter plot. It's not used to say exactly where this point is, but it is about seventy two.

00:45:44 Daniel Chen
But for this factor of two. So because one of these columns, one of these variables is categorical

00:45:50 Daniel Chen
One of the axes is okay if it's not exactly on the dot of two. Because we don't have a two point something factor or a value for t_vol.

00:46:03 Daniel Chen
So this is a figure that's again just throwing a little bit more information. You have this distribution. Where do the plots land? And you can see here the NA. There's fewer points, so that gives you like, I know the distribution looks like this, but it's also because there's only one, two, three, four, five, six points here. So you're overlaying, and you have a little bit more information for what's happening in your data.

00:46:28 Daniel Chen
If you've never seen a violin plot before

00:46:31 Daniel Chen
That's okay. I know a lot of publications sometimes don't publish violin plots because box plots are.

00:46:40 Daniel Chen
Very traditional stats. You'll probably see this in a lot of research papers, but that doesn't stop you from trying to understand your data and figure out what is happening.

00:46:51 Daniel Chen
You look at a plot like this, right? So not all the code or all the figures that make it for public consumption. That's not the only set of plots that get generated.

00:47:04 Daniel Chen
And here again, this is me showing that.

00:47:07 Daniel Chen
The points are going to move because it's random, and there are ways you can fix the randomness. But again, this is another way of showing you, hey, we have a common base, like the base layer uses the same data and the same x and y values. I want to take those same base values and overlay different visualizations on top.

00:47:30 Daniel Chen
So another type of plot that we might want to do is what happens when we're looking at two variables, but both of them are categorical.

00:47:41 Daniel Chen
That's an example of, and I, I kind of jumped ahead.

00:47:48 Daniel Chen
That's an example of creating a scatter plot in ggplot. It's called geom_point. So just like how we made points before, a scatter plot is what happens when you're looking at two continuous variables. And you can see here for the different p volume.

00:48:07 Daniel Chen
So this is p volume, not t_vol. So different variable here. That's a continuous variable, and then there's another continuous variable, which is a lab blood result that we're trying to look at.

00:48:23 Daniel Chen
And so we can get a scatter plot here.

00:48:26 Daniel Chen
If you are trying to look at a scatter plot

00:48:30 Daniel Chen
But you want to add a categorical variable to it. One thing you can do is say, 'Hey, I want the color of the points to be colored by some other value in our data.' And this is really what makes ggplot pretty nice to work with, where you can say, 'Hey, I want to provide another aesthetic mapping.'

00:48:53 Daniel Chen
Instead of x, y, I want color. There's color, there's fill, there's shape, there's size.

00:49:01 Daniel Chen
In this case, color based off of values of this SGS variable

00:49:08 Daniel Chen
And now we get colors by points.

00:49:11 Daniel Chen
But again, this is a variable that I want colored by

00:49:17 Daniel Chen
And again, we have to go back to what type of variable is being encoded here. This, if I look at this figure and you look at the legend.

00:49:27 Daniel Chen
This makes it seem like 1.5 is a valid value. It looks like a slow continuous color bar.

00:49:38 Daniel Chen
And it makes me think, if it's really dark blue, it's a value of one. If it's slightly lighter, maybe it's like 1.5, and it gets to two, and maybe there's a 2.75 before three and a four. Like maybe that's what's happening here.

00:49:55 Daniel Chen
But that's not actually true. The sgs variable is very similar to that t_vol variable, where it's a number, but it's actually incremental steps.

00:50:07 Daniel Chen
So we have the same problem

00:50:09 Daniel Chen
Where if we really want to visualize this, we have to turn it into a group. And now you'll see that 1.5 does not exist as a value here.

00:50:22 Daniel Chen
The example I used to use is a data set that comes out of R by default, like looking at the Motor Trends Cars data set. We do the same thing with how many cylinders a car has. There's no such thing as a four and a half cylinder car. They come in multiples of two.

00:50:40 Daniel Chen
Assuming you know anything about cars. That's for the most part how they run or how they're built, and so we have the same problem where that original figure made it seem like 1.5 is a valid value, but it's not. It's one, two, three, or four, and there's nothing else in between.

00:50:59 Daniel Chen
And so that's an example of yes, the even as some something as simple as the legend

00:51:07 Daniel Chen
If you don't specify it correctly

00:51:10 Daniel Chen
Can really change what is happening with

00:51:15 Daniel Chen
How someone might interpret your data set.

00:51:19 Daniel Chen
The last thing, or the last sort of major topic, is what happens if we have two continuous variables and we want to add more categories. Like I'm using color. Maybe you want to use shape, but if you're using color and shape, sometimes it's really hard to tell the difference between a blue circle and a green star and a green circle. Things can kind of get blended together. So sometimes using shape and color, I would suggest.

00:51:50 Daniel Chen
Have shape and color typically on the same variable.

00:51:54 Daniel Chen
So you can really emphasize the difference for something. But again, that's not always a rule set in stone.

00:52:03 Daniel Chen
But if you end up in a scenario where you have more splits in data you want to look at

00:52:09 Daniel Chen
There is this notion called a facet. And so, if we're looking at this plot here, it's the same thing as before: PVOL, PSA. SGS, so that's this figure. But if I wanted to add another categorical variable to it

00:52:25 Daniel Chen
One thing we can do is take this scatter plot and split it by the different categories.

00:52:30 Daniel Chen
And again, this is literally what made me like not leave R for many years when I was doing data work

00:52:40 Daniel Chen
Because I can now run this extra line, this extra layer called a facet_wrap, our facet

00:52:46 Daniel Chen
And say, hey, I want each one of those scatter plots, faceted or split by this other variable called RBC_age_group

00:52:55 Daniel Chen
And it will give me a separate scatter plot. Small multiples. Exactly what's happening.

00:53:01 Daniel Chen
It's really like once you learn the word facet, or you can prompt the word facet now. Now you get this figure. It's a very simple addition to make.

00:53:14 Daniel Chen
And if you have another variable you want to add, instead of facet_wrap, there's facet_grid. Think of a grid with two variables. You can have two variables.

00:53:24 Daniel Chen
And now you have I forgot. Age group is on this axis, and recurrent zero and one is on the other axis.

00:53:34 Daniel Chen
And that's typically the limit where you can start. Maybe you end up making shapes like that, or maybe you have to make more of these small multiples, but this is pretty much a really good way to see. There's a lot of red here.

00:53:51 Daniel Chen
And red is looking at family history. There is a family history. Red is for yes. There is a family history of this, but it's also when you can see there's a recurrence under the facet for one. So it seems like if you have a family history.

00:54:14 Daniel Chen
Even though there aren't that many cases of this in the three groups, I'm trying to remember what the group is called RBC_age_group.

00:54:25 Daniel Chen
It seems like family history is really related to

00:54:29 Daniel Chen
Or correlated to having a recurrence.

00:54:35 Daniel Chen
May not all your data look break out like this fairly cleanly like that.

00:54:41 Daniel Chen
Again, this is part of data exploration. You are trying to learn more and figure out what is happening in your dataset.

00:54:48 Daniel Chen
So that's visualizations in R or using ggplot. It really comes down to this series of figures of knowing how many variables you're trying to plot.

00:55:01 Daniel Chen
And then from those variables you're trying to plot which type of variable is encoded. Is it numeric? Then is it continuous or discrete? Because if it's discrete, you might need to force it into a factor or a category.

00:55:15 Daniel Chen
And then if it's a category, is it nominal, ordinal, or binary?

00:55:21 Daniel Chen
We for the most part haven't really dealt with or plotted anything with them, but this will come into play, especially when you're trying to fit models. So logistic regression is binary, yes or no, zero and one. Ordinal

00:55:36 Daniel Chen
There is a difference between zero, one, and two, and two is very different from zero. It's not just a sequence of binary differences, although there are models that treat it that way.

00:55:49 Daniel Chen
Or is it? I just have groups, and there's no order to them, and I'm just trying to predict which bucket you're in.

00:55:55 Daniel Chen
So anything can. A lot of things can be turned binary. If you have turtle, snail, and butterfly, you can be Turtle and not turtle.

00:56:05 Daniel Chen
You can almost encode a lot of categorical variables into binary, and that is a very simple and I would say common first approach to a lot of data modeling. Doing something like that, even with ordinal variables.

00:56:20 Daniel Chen
If you're looking at disease stages, sometimes it's just stage zero and everything else, or stage four and everything else. And you've turned a disease model that has different stages into something that's binary, or you can do something like high stages and low stages. And again, that makes some of the statistics easier, but you're losing information. So then the statistics is less strong to make a certain claim, or it's answering a slightly different question.

00:56:51 Daniel Chen
But I've done it in the past, especially when I'm just exploring the data of what happens when we make different cuts of our data. A binary cut is the easiest and a good first exploration pass.

00:57:05 Daniel Chen
And again, all of those play into how you visualize your data as well.

00:57:12 Daniel Chen
So that's everything I had to talk about. Next week, it won't be—I don't think it'll take the full hour.

00:57:19 Daniel Chen
We will go over how we can install everything that you see here. Try to run something on your local computer if you're interested in doing all of that.

00:57:30 Daniel Chen
And then the following is just like then I don't think I have anything unless you want to talk about models and LLMs and other stuff.

00:57:42 Daniel Chen
So if you add more dimensions

00:57:44 Daniel Chen
It's not necessarily that dots get smaller. There are ways to make the dots bigger. You can totally do that. Just make the dots bigger. But then you will eventually end up with overplotting issues.

00:57:56 Daniel Chen
And there are ways to deal with that. I think it's called hexbin.

00:58:03 Daniel Chen
So if you have this problem where you're overplotting, or there's too many dots on top of one another, hold on.

00:58:11 Daniel Chen
Why do I not have a good example?

00:58:17 Daniel Chen
So what can happen is you'll almost make like you. What people have done is there's a.

00:58:24 Daniel Chen
A type of plot called hexbin, and instead of plotting each individual point, you're plotting the count of a group of points in a certain location. So you almost make a heat map of your points. There are different ways to work with what happens when you're dealing with overplotting.

00:58:42 Daniel Chen
Again, sometimes you are just plotting mean, median, and mode with the confidence interval. That's just with bar graphs and a line. You can totally do that in ggplot.

00:58:54 Daniel Chen
And almost every time when you end up in the actual publication journal, you end up in the very traditional standard plots that most people are used to seeing. Because if you start writing or publishing something that people don't expect, you have to write a lot of text on how to read this plot. That's what ends up happening.

00:59:15 Speaker 3
So no thanks for the answer. I was just thinking that sometimes you tend to go back to the averages, so you go from the micro level of the data, and then at some point you want to see even more, so then you go back to the macro level, and it's like that analytical cycle. Thanks a lot for the resource. I haven't seen those plots, so that's quite interesting. Thanks.

00:59:41 Daniel Chen
There again, when you end up with a lot of data, there's a it.

00:59:47 Daniel Chen
It's very tricky to get the right visualization to see everything

00:59:51 Daniel Chen
And so, overplotting. That's a very common word you can search for. This figure now looks overplotted. Can you help me, AI? What are some techniques? The first one that comes into my mind is a hexbin plot, where they're binning just like a histogram, but they're binning the histogram in the scatter plot view, which is kind of nice.

01:00:15 Daniel Chen
So that's time. When this closes, all of the transcription and notes, I'll just give it an hour or so, and I'll post everything up on the GitHub page. And then we also have another hand. I'll take a hand, Emmanuel.

01:00:36 Daniel Chen
Hi.

01:00:39 Daniel Chen
Can you hear me? I can hear you.

01:00:41 Speaker 4
I just wanted to get these. It might sound a bit simplistic, but I just wanted to get it from you. Will it be the dataset and the variable that we are looking at that we determine the tool you use in your analysis?

01:00:59 Daniel Chen
At least the tool you use. Like, if you're

01:01:05 Daniel Chen
I'm going to define tool. Is it ggplot, the plotting tool?

01:01:10 Daniel Chen
Looker, that tool,

01:01:14 Daniel Chen
I want. That's the question you ask. I need to look at my data and visualize it with a figure.

01:01:19 Speaker 4
Exactly.

01:01:20 Daniel Chen
No

01:01:21 Daniel Chen
That would I would say that if you're debating between ggplot and R and Looker, that I would say that decision is made determining that is determined by how comfortable you are with code and not code.

01:01:35 Daniel Chen
But once you pick one, even in Looker, you have the same problem.

01:01:39 Daniel Chen
I have this blood data set. I want to look at these two variables.

01:01:42 Daniel Chen
You still go through the same thought process. This is continuous. That's continuous. I should probably use a scatter plot. I want to use this as another variable. It's a categorical. Let's make sure it's a color variable and it's treated like a category. And then maybe I have other facets I want to use. They're also categories.

01:02:02 Daniel Chen
A lot of visualization tools have this feature in it. Then you just have to decide if you want to do it through code or not code, but the magic of AI these days

01:02:16 Daniel Chen
Code is becoming a lot easier to produce because you can

01:02:21 Daniel Chen
As long as you know the words to describe what you want.

01:02:27 Daniel Chen
It will then create the code for the visualization, and I would even argue that visualization code or visualizations are much harder to mess up, assuming your data is correct to begin with.

01:02:36 Daniel Chen
Because once the figure gets plotted, it's really hard to mess that up.

01:02:41 Daniel Chen
It's easy to mess up data cleaning code, and modeling has a lot of gotchas. But once you see what variables are being used in which part of the figure, then it's really like that's not going to get messed up.

01:02:53 Speaker 4
Yeah.

01:02:55 Speaker 4
Thank you so much. That's helpful.

01:03:00 Daniel Chen
So stay tuned. In the next 24 hours or so, I'll get all the notes and everything up. I will have to remember to get all of the previous code and everything up there as well.

01:03:13 Speaker 4
Have a good evening. Thank you very much.

01:03:15 Daniel Chen
Take care, everyone.

01:03:17 Daniel Chen
Thank you.
