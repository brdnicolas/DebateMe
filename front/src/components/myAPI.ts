import axios from 'axios'
export default axios.create({
    baseURL: 'https://api.hugovast.tech/',
    timeout: 2000,
    headers: {
        Authorization: localStorage.token,
    }
})