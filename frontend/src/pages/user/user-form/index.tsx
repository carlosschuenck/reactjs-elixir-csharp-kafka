import { Grid, IconButton, TextField, Container, Button } from '@material-ui/core';
import { Save } from '@material-ui/icons';
import React, { FunctionComponent, useState } from 'react';
import { saveUser } from '../../../services/user-service';
import { useHistory } from 'react-router-dom'

const UserForm: FunctionComponent = () => {
  const history = useHistory();
  const [ name, setName ] = useState('')

  const invokeSaveUser =  async () => {
    await saveUser({ name })
    history.goBack()
  }

  return (
    <Container>
      <Grid container justify="center" spacing={2} style={{margin: 10, marginTop: 20}}  >
        <Grid item xs={6}>
            <TextField id="outlined-basic" 
                       fullWidth 
                       label="Name" 
                       value={name} 
                       variant="outlined" 
                       onChange={event => setName(event.target.value)}/>
        </Grid>
        <Grid item>
          <IconButton aria-label="search-task" onClick={invokeSaveUser}>
            <Save  fontSize="large" />
          </IconButton>
        </Grid>
      </Grid>
     </Container>
  );
}

export default UserForm;