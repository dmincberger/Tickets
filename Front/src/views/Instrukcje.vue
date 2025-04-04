<script>
import Navbar from "../components/Navbar.vue"
import Footer from "../components/Footer.vue";
import { get } from "../api";
import router from "../router";
import { userTokenStore } from "../store/token";
import TicketComponent from '../components/TicketComponent.vue';


export default {

  data() {
    return {

    }
  },
  components: {
    Navbar,
    Footer,
  },
  methods: {
    
  },
  computed: {

  },
  async mounted() {
    const token = userTokenStore()
    console.log(token.getRole())
    if(token.getRole() == "user"){
      router.push({ path: 'user' })
    }


  }
}
</script>

<template>

  <div class="all">
    <Navbar></Navbar>
    <div class="main" style="min-width: 840px;">
      <div class="descriptionBar">
<p>'Ten dokument opisuje proces przygotowania w pełności projektu "Tickets support" żeby móc go wystawić na internecie.
<br>
----------------------------- BACKEND ----------------------------------------
<br>
Backend wykorzystuje:
-typescript
-express
-nedb
-JWT
-JWKS-client
-Azure API
<br>
Frontend wykorzystuje:
-Vue
-Tailwind
-Vite
-msal
<br>
Do wystawienia projektu uzywamy:
docker
docker network
nginx 
<br>
Zadaniem backendu w tym projekcie jest:
-Przechowywanie danych 
-Weryfikacja żądań na serwer
-Przesyłanie potrzebnych danych.
<br>
Zadaniem frontendu w tym projekcie to:
-Zalogowanie przez microsoft
-wyświetlenie danych
-przesłanie danych na serwer
<br>
--------------------------------- SETUP PROJEKTU ----------------------------
<br>
Serwer nasłuchuje na porcie 3001, więc taki port należy wystawić na dockerze (można zmienić oczywiście)
Frontend nasłuchuje na porcie 5173, taki port więc należy wystawić na dockerze
Nginx nasłuchuje na requesty na porcie 80, aczkolwiek port 80 jest już użyty,
polecam wystawić port 80 ale przypisać go do innego na maszynie lokalnej (w moim przypadku, port 1234 do tego służy.)
<br>
należy utworzyć contenery z dostępnych, i gotowych dockerfiles. (jeżeli pliki znikną/zgubią się/cokolwiek to musicie zrobić własne tak żeby działało.)
contenery dodać do wspólnej sieci używając docker network.
nginx spodziewa się nazw support_frontend oraz backend_frontend, jeżeli zmienicie nazwy kontenerów, należy je również zmienić w nginx.conf
zforwardować network traffic z portu na którym jest wystawiony nginx na maszynie lokalnej na router.
w /etc/nginx/nginx.conf jest gotowa konfiguracja, nie powinno się jej zmieniać chyba że zmienia się endpointy na serwerze.
<br>
w przypadku zmiany adresu strony (obecnie jest to support.514.net.pl) 
należy dokonać podobnej zmiany na endpointach w aplikacji "Tickety" na Azure, albo logowanie nie będzie działać.
contenery używając komendy docker run powinno włączać się z opcjami:
-i -t -p --name [ODPOWIEDNIA_NAZWA] --network [NAZWA_SIECI_DOCKERA][PORT_MASZYNY_LOKALNEJ]:[PORT_WYSTAWIONY_NA_DOCKERZE]                                                               
<br>
Proszę pamiętać że inne projekty również okupują porty na routerze, 
należy dogadać się z nauczycielem zarządzającym routerem którego portu można użyć.
'</p>
        </div>
      </div>
    <Footer></Footer>


  </div>


</template>

<style scoped>
label {
  @apply mt-2;
}

.all {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
}

.inactiveBtn {
  filter: grayscale(75%);
  opacity: 75%;
}

.main {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  gap: 5px;
  padding: 10px;
}

.descriptionBar {
  width: 100%;
  display: flex;
  flex-direction: row;
  gap: 10px;
  border-bottom: 1px solid lightgray;
}

h2 {
  @apply font-bold w-auto;
}

i{
  @apply text-black z-50 cursor-pointer
}

.columnHeader{
  @apply relative flex flex-row items-center justify-between
}
</style>
