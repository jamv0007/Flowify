# Flowify
Aplicación que permite reconocimiento de plantas con IA y mostrar información

La aplicación permite usar una imágen de una planta o flor de la galeria y usar un modelo entrenado para reconocer la planta y posteriormente obtener los datos de Wikipedia usando la API si es posible para mostrar una pantalla con información de la planta. La aplicación usa el modelo FlowerClassify.mmodel y los pod de Alamofire para peticiones web a la API de Wikipedia y SDWebImage para obtener la imágen de la misma página.

En primer lugar se tiene la pantalla principal donde se pueden escoger la foto con el botón de la esquina superior: 

<img width="200" height="400" alt="Captura de pantalla 2023-10-22 a las 16 30 29" src="https://github.com/jamv0007/Flowify/assets/84525141/76a67d98-2221-46ac-9861-f48f308c7042">
<img width="200" height="400" alt="Captura de pantalla 2023-10-22 a las 16 31 26" src="https://github.com/jamv0007/Flowify/assets/84525141/4cc6fc6a-5532-4908-bb3b-31653d26ce92">

Una vez que se utilice el botón de bucar, se identifica con el modelo la planta y se mostrará un pop up de que la imágen no se ha podido obtener información o se pasa a una vista con una imágen, nombre y descripcion de la flor.

<img width="200" height="400" alt="Captura de pantalla 2023-10-22 a las 16 51 12" src="https://github.com/jamv0007/Flowify/assets/84525141/493abeb0-cd2c-4e08-8ace-075701733078">

## Las imágenes deben ser lo mas limpias posibles para que no se equivoque el modelo al identificarlo
