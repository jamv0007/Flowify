# Flowify
Aplicación que permite reconocimiento de plantas con Machine Learning y mostrar información además de almacenar informacion de las platas al cuidado.

La aplicación permite usar una imágen de una planta o flor de la galeria y usar un modelo entrenado para reconocer la planta y posteriormente obtener los datos de Wikipedia usando la API si es posible para mostrar una pantalla con información de la planta. La aplicación usa el modelo FlowerClassify.mmodel y los pod de Alamofire para peticiones web a la API de Wikipedia y SDWebImage para obtener la imágen de la misma página.

En primer lugar se tienen dos pantallas con un navigation tab: Una pestaña contiene el modulo para identificacion de plantas, donde se puede escoger la foto con el boton superior desde la galeria. El otro contiene el modulo para registrar plantas propias y notificaciones de riego (esto esta en proceso) con base de datos Realm.  

<img width="200" height="400" alt="Captura de pantalla 2023-11-11 a las 12 20 28" src="https://github.com/jamv0007/Flowify/assets/84525141/7fe2c4af-1fb4-4801-b387-1fcb2a05971b">
<img width="200" height="400" alt="Captura de pantalla 2023-11-11 a las 12 21 00" src="https://github.com/jamv0007/Flowify/assets/84525141/83403e25-ed54-45a3-93d1-dff1fd2e59bc">
<img width="200" height="400" alt="Captura de pantalla 2023-11-11 a las 12 21 51" src="https://github.com/jamv0007/Flowify/assets/84525141/90b8e356-4b38-4fd2-95b9-35e8d70d810c">

Una vez que se utilice el botón de bucar, se identifica con el modelo la planta y se mostrará un pop up de que la imágen no se ha podido obtener información o se pasa a una vista con una imágen, nombre y descripcion de la flor.

<img width="200" height="400" alt="Captura de pantalla 2023-11-11 a las 12 22 17" src="https://github.com/jamv0007/Flowify/assets/84525141/f9e99fbb-83a9-4039-a250-99d5cb6b5ee8">

El otro modulo tiene una lista de plantas añadidas por el usuario. Al añadir una nueva se debe rellenar el cuestionario con un nombre, foto opcional y condiciones de la planta.

<img width="200" height="400" alt="Captura de pantalla 2023-11-11 a las 12 23 22" src="https://github.com/jamv0007/Flowify/assets/84525141/cf0052bc-285b-4315-956a-c3523e116bfd">
<img width="200" height="400" alt="Captura de pantalla 2023-11-11 a las 12 23 37" src="https://github.com/jamv0007/Flowify/assets/84525141/b9aaa174-33ac-4881-9953-40e9a092b1f3">

<img width="200" height="400" alt="Captura de pantalla 2023-11-11 a las 12 23 57" src="https://github.com/jamv0007/Flowify/assets/84525141/a63c0659-2456-4cb9-923c-3e1af7601e0c">
<img width="200" height="400" alt="Captura de pantalla 2023-11-11 a las 12 24 15" src="https://github.com/jamv0007/Flowify/assets/84525141/9a787a3e-0edb-44e9-aaea-a69d0a706ad7">

Al mantener un elemento se puede modificar o eliminar el elemento.

<img width="200" height="400" alt="Captura de pantalla 2023-11-11 a las 12 24 42" src="https://github.com/jamv0007/Flowify/assets/84525141/f3e21a52-9a03-40fa-8931-01bc3e2dfe7a">
<img width="200" height="400" alt="Captura de pantalla 2023-11-11 a las 12 26 26" src="https://github.com/jamv0007/Flowify/assets/84525141/1dbb9682-fee1-4c85-a680-ff4336915218">


