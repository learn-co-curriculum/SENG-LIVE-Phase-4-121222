import React, { useState} from 'react'
import styled from 'styled-components'
import {useHistory} from 'react-router-dom'

function ProductionForm({addProduction}) {
  const [formData, setFormData] = useState({
    title:'',
    genre:'',
    budget:'',
    image:'',
    director:'',
    description:''
  })
  const [errors, setErrors] = useState([])
  const history = useHistory();

  const handleChange = (e) => {
    const { name, value } = e.target
    setFormData({ ...formData, [name]: value })
  }

  function onSubmit(e){
    e.preventDefault()
    //Create a Production Or render errors from the production
    // '/productions'
    fetch('/productions',{
      method: 'POST',
      headers: {
        "Content-type":"application/json"
      },
      body: JSON.stringify(formData)
    })
    .then(res => {
      if(res.ok){
        res.json().then(production => {
          addProduction(production)
          history.push(`/productions/${production.id}`)
        })

      } else {
        res.json().then(json => setErrors(Object.entries(json.errors).map(error => `${error[0]}: ${error[1].join(",  ")}`)))
      }
    })
   
  }

    return (
      <div className='App'>
      {errors&& errors.map(error => <h3 style={{color:'red'}}>{error.toUpperCase()}</h3>)}
      <Form onSubmit={onSubmit}>
        <label>Title </label>
        <input type='text' name='title' value={formData.title} onChange={handleChange} />
        
        <label> Genre</label>
        <input type='text' name='genre' value={formData.genre} onChange={handleChange} />
      
        <label>Budget</label>
        <input type='number' name='budget' value={formData.budget} onChange={handleChange} />
      
        <label>Image</label>
        <input type='text' name='image' value={formData.image} onChange={handleChange} />
      
        <label>Director</label>
        <input type='text' name='director' value={formData.director} onChange={handleChange} />
      
        <label>Description</label>
        <textarea type='text' rows='4' cols='50' name='description' value={formData.description} onChange={handleChange} />
      
        <input type='submit' value='Create Production' />
      </Form>
      </div>
    )
  }
  
  export default ProductionForm

  const Form = styled.form`
    display:flex;
    flex-direction:column;
    width: 400px;
    margin:auto;
    font-family:Arial;
    font-size:30px;
    input[type=submit]{
      background-color:#42ddf5;
      color: white;
      height:40px;
      font-family:Arial;
      font-size:30px;
      margin-top:10px;
      margin-bottom:10px;
    }
  `