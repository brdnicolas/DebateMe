import axios, {AxiosInstance} from 'axios'

class DAO {
    private axios: AxiosInstance;

    constructor() {
        this.axios = axios.create({
            baseURL: 'https://api.hugovast.tech/',
            timeout: 2000,
            headers: {
                Authorization: localStorage.token,
            }
        })
    }

    async getThemes() {
        let rep = {};
        await this.axios.get('themes').then((response: { data: any}) =>  {
            rep = response.data;
        } );
        return rep;
    }

    async getPostesByTheme(themeID) {
        let rep = {};
        await this.axios.get('themes/' + themeID + "/questions").then((response: { data: any}) =>  {
            rep = response.data;
        } );
        return rep;
    }

    async postComment(datas) {
        let rep = {};
        await this.axios.post('posts', datas).then((response: { data: any}) =>  {
            rep =  response;
        } );
        return rep;
    }

    async getComments(questionID) {
        let rep = {};
        await this.axios.get("questions/" + questionID + "/posts").then((response: { data: any}) =>  {
            rep =  response.data;
        } );
        return rep;
    }

    async getQuestion(themeID, questionID) {
        let rep = {};
        await this.axios.get("themes/" + themeID + "/questions/" + questionID).then((response: { data: any}) =>  {
            rep =  response.data;
        } );
        return rep;
    }

    async getUserByName(profilName) {
        let rep = {};
        await this.axios.get("users/search/" + profilName).then((response: { data: any}) =>  {
            rep =  response.data;
        } );
        return rep;
    }

    async getUserByID(userID) {
        let rep = {};
        await this.axios.get("users/" + userID).then((response: { data: any}) =>  {
            rep =  response.data;
        } );
        return rep;
    }

    async getCurrentUser() {
        let rep = {};
        await this.axios.get("users/me/profile").then((response: { data: any}) =>  {
            rep =  response.data;
        } );
        return rep;
    }

    async patchChangeQuote(userID, datas) {
        let rep = {};
        await this.axios.patch("users/" + userID, datas).then((response: { data: any}) =>  {
            rep =  response.data;
        } );
        return rep;
    }

    async patchChangeProfilPicture(userID, datas) {
        let rep = {};
        await this.axios.patch("users/" + userID, datas).then((response: { data: any}) =>  {
            rep =  response.data;
        } );
        return rep;
    }

    async postInscription(datas) {
        let rep = {};
        await this.axios.post("auth/register", datas).then((response: { data: any}) =>  {
            rep =  response.data;
        } );
        return rep;
    }

    async postConnexion(datas) {
        let rep = {};
        await this.axios.post("auth/login", datas).then((response: { data: any}) =>  {
            rep =  response.data;
        } );
        return rep;
    }

}

export default DAO;