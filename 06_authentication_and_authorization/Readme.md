# Authentication
## SWBATs:
- [ ] Explain the difference between authentication and authorization
- [ ] Explain what sessions and cookies are
- [ ] Explain the importance of CORS
- [ ] Explain the purpose of bcrypt
- [ ] Observe how bcrypt is used to protect User data
- [ ] Observe how to configure CORS
- [ ] Observe a full-stack authentication workflow via sign up page
- [ ] Observe a full-stack authorization workflow via log in page
- [ ] Observe how to protect client-side routes from unauthorized Users
- [ ] Observe how to protect server-side routes from unauthorized Users using before_actions

User -< Ticket >- Production
![associations.png](assets/associations_fixed.png)

## Deliverables
- Review Authentication and password security with the following topics
	- Storing passwords in a plain text string
	- Bruit force attacks
	- Hashing
	- Rainbow Tables
	- Salting 

Note: adding BCrypt only takes a few lines of code; the following is to explain what is going on underneath the hood.

- Demo BCrypt
- Review the BCrypt docs https://github.com/bcrypt-ruby/bcrypt-ruby

`gem install bcrypt`

- Demo the following in the rails console
    - `cow1 = BCrypt::Password.create('cow')`
    - BCrypt creates an instance of a hashed password when given a string.
    -  The hash can be saved in the DB to identify the user later. 
    - `cow2 = BCrypt::Password.create('cow')`
    - `cow1 === cow2` #false
    - Even when given the same password, BCrypt produces a different hash. 


    - Compairing a BCrypt instance with the correct password returns true
    `cow1 == ‘cow’` #true

    - `==` in BCrypt is a method on the Password class for BCrypt. It might be easier to think of it more like this. 
    - cow1.==('cow')
    - BCyrpt docs https://github.com/bcrypt-ruby/bcrypt-ruby/blob/master/lib/bcrypt/password.rb
    ```
        # Compares a potential secret against the hash. Returns true if the secret is the original secret, false otherwise.	
        #  def ==(secret)
        #     super(BCrypt::Engine.hash_secret(secret, @salt))
        #  end
    ```
    - The hash is made of two parts salt and checksum
    - `cow1.checksum`
    - `cow1.salt`
    - If BCrypt is given the exact string and the same salt, it will produce the same hash. BCrypt can compare a user's input with the hash saved in the database.
    - `cow3 = BCrypt::Engine::hash_secret('cow', cow1.salt)`
    - `cow1 ==  cow3 #true`

- Demo adding BCrypt to a project
    - Create a migration to change password to password_digest
    - Add has_secure_password to the User model
    - Re-seed and check your passwords in the rails console `User.first.password_digest`
        - Notice that the password attribute in User.create didn't need to be update to `password_digest`. Password doesn't correspond to database column. Instead, Bcyrpt will hash the password and save it to the password_digest column.
    - You can imagin if we built the functionality ourself it would look something like this:
    ```
        def password=(new_password)
            alt = BCrypt::Engine::generate_salt
            self.password_digest = BCrypt::Engine::hash_secret(new_password, salt)
        end
    ```

    - Add the create route to users in routes.rb
    - Add a create action in the Users controller
    - Test the route with the client's SignUp component. If the response is sucessful, the client should direct to the UsersPage. 
    - Verify the password is hashed in the rails console 

- Review Authorization 
    - Authentication vs Authorization
    - Cookies
    - Sessions
    - Same site cookies 
    - CORS and why it's not necessary to configure with same-site cookies

- Demo Login 
    - In routes.rb create custom login, logout and authorized_user routes.
    ```
        post '/login', to: 'sessions#create'
        delete '/logout', to:'sessions#delete' 
        get '/authorized_user', to: 'users#show'
    ```

    - Create a Sessions controller for these routes. Note: Since the Authorization routes do not connect to a model or data in our database, a controller to manage the actions is all that's needed. 

    - Add a create actions to the session controller to find a user by name from params.
    
    - Once found, call .authenticate with the params password as an argument on the User. 
    
    - Create a condition, if the User is found and authenticated, create a response with the user information with the status of ok else, create a response with the error message "Invalid Password or username."

    - Test the `/login` route and action with the client's login page. 

    - The error message should be rendered if the login fails, and the page should redirect to the user's page if it's successful.

- Demo sessions
    - The application must be configured for cookies and sessions. In the config/application.rb  Enable cookies and middleware
    ```
        config.middleware.use ActionDispatch::Cookies
        config.middleware.use ActionDispatch::Session::CookieStore
        config.action_dispatch.cookies_same_site_protection = :strict
    ```
    - In the application controller add 	   `include ActionController::Cookies` to the top
    
    - Stop and restart the rails server to enable the changes.

    - On login, keep the User logged in by setting the user's id to sessions. 
    
    - In the sessions controller in the create action, add `session[:user_id] = user.id`
    
    - Add a debugging tool to pause the code and view the session hash.

    - The application now needs a method to confirm if a user_id is saved to sessions. In the application controller create a `current_user` method that can find the User by the session user_id and an `authorize_user` method that will generate a response with an error of "Not authorized" if the current_user does not return the User.
   
    - Add a before action that will run authorized_user to the top of the application controller. This will run the authorized_user method before every action.
   
    - The login and signup routes will not require the user_id.
   
    - Add a skip before action for User create action and Sessions login action.

    ```
        #application_controller
        before_action :authorized_user


        def current_user
            User.find_by(id: session[:user_id])
        end

        def authorized_user  
            return render json: { error: "Not authorized" }, status: :unauthorized unless current_user
        end
  
    #sessions and users controllers
        skip_before_action :authorized_user, only: [:create]

    ```

    - In the show action of the User controller, replace the User.find with the current_user method.
   
    - At this point, any method that finds the user can be replaced with current_user



- Demo Saving the User to state. 
    - The client must now be configured to verify that a user is logged in.
   
    - In App, define a variable in state called `currentUser`. When a user is logged in or signed up, update the state with the user object.

    - In the Apps, useEffect add a GET request to `authorized_user` if the user is returned successfully, set the user to state and fetch productions.

    - Also, in App conditionally render the login page if a user is not saved to state else, render the rest of the app.



- Demo logout
    - Create a log-out button that makes a delete request to `/logout` in the Navigation component.
    
    - In the sessions controller add a delete action that removes the user_id from sessions

    ```

        def delete
            session.delete :user_id
            head :no_content
        end


    ```

    - Test the logout to confirm the user is successfully removed from sessions.


- Bonus: add an admin attribute to User and only render the ProductionForm and EditProduction forms if the User has the attribute of admin.








Images:
landingPageImage
https://unsplash.com/photos/POd35V_uE4k
Published on February 16, 2018
Free to use under the Unsplash License
Dancer: Olivia Tarchick