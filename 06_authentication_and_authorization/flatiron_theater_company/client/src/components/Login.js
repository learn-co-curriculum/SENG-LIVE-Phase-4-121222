import React, {useState} from 'react'
import {useHistory} from 'react-router-dom'
import {Form} from '../styled/Form'

function Login({updateUser}) {
    const [formData, setFormData] = useState({
        name:'',
        password:''
    })
    const [errors, setErrors] = useState([])
    const history = useHistory()

    const {name, email, password} = formData

    function onSubmit(e){
        e.preventDefault()
        const user = {
            name,
            password
        }
       
        fetch(`/login`,{
          method:'POST',
          headers:{'Content-Type': 'application/json'},
          body:JSON.stringify(user)
        })
        .then(res => {
            if(res.ok){
                res.json().then(user => {
                    updateUser(user)
                    history.push(`/users/${user.id}`)
                })
            }else {
                res.json().then(json => setErrors(json.error))
            }
        })
       
    }

    const handleChange = (e) => {
        const { name, value } = e.target
        setFormData({ ...formData, [name]: value })
      }
    return (
        <> 
        <Form onSubmit={onSubmit}>
        <label>
          Username
          </label>
        <input type='text' name='name' value={name} onChange={handleChange} />
      
        <label>
         Password
         </label>
        <input type='password' name='password' value={email} onChange={handleChange} />
       
       
        <input type='submit' value='Log in!' />
      </Form>
      {errors?<h2>{errors}</h2>:null}
        </>
    )
}

export default Login
