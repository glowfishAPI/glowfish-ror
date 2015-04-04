
glowfi.sh the Rails Way: Now with machine guns and rocket launchers.
-----------

**Installation**

    gem install glowfish

**Setup**

    require "glowfish"
    glower = Glowfish::API.new('<GLOWFISH_SID>', '<GLOWFISH_AUTH_TOKEN>')

**Useage**

Get ready for some simple machine learning...

*Training*

    response = glower.train({ # the data set
	    'feature_name1': [1, 2, 3, 4, ...etc],
	    'feature_name2': [9, 4, 5, 6, ...etc]
    }, { # the response set
	    'class': [4, 3, 5, 6, ...etc]
    }, {...}) # config options

*Predict*
It's important to note that predicting will throw an error if you have not trained against a data set first.

    response = glower.predict({ # the data set
	    'feature_name1': [1, 2, 3, 4, ...etc],
	    'feature_name2': [9, 4, 5, 6, ...etc]
    }, { # the response set
	    'class': [4, 3, 5, 6, ...etc]
    }, {...}) # config options

*Clustering*

    response = glower.cluster({ # the data set
	    'feature_name1': [1, 2, 3, 4, ...etc],
	    'feature_name2': [9, 4, 5, 6, ...etc]
    }, {...}) # config options

*Feature Selection*

    response = glower.feature_select({ # the data set
	    'feature_name1': [1, 2, 3, 4, ...etc],
	    'feature_name2': [9, 4, 5, 6, ...etc]
    }, { # the response set
	    'class': [4, 3, 5, 6, ...etc]
    }, {...}) # config options
    
*Filter Train*

    response = glower.filter_train(
      [1, 2, 3, 4, ...etc] #userids,
      [1, 2, 3, 4, ...etc] #productids,
      [1, 2, 3, 4, ...etc] #ratings
    )
    
*Filter Predict*

    response = glower.filter_predict(
      [1, 2, 3, 4, ...etc] #userids,
      [1, 2, 3, 4, ...etc] #productids,
      [1, 2, 3, 4, ...etc] #ratings
    )

**The Response**

	<Response> {
	  @code = [200-500]
	  @message = "STRING MESSAGE FOR API RETURN"
	  
	  @data = {...data...}
	  @errors = {...key value errors...}
	  @metrics = {...timing and counting metrics from the API...}
	}

**Further Documentation**

Docs - http://glowfish.readme.io/  
Registration - http://glowfi.sh/
