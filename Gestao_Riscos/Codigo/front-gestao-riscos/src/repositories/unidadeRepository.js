import Repository from './Repository';
const resource = "/unidades"

export default{

  findAll() {
    return Repository.get(`${resource}`)
  }

  

}