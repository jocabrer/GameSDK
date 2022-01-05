-- Amalgamated Terminal v1.0.5
-- Created by Cuartas

Script.LoadScript('Scripts/Entities/SCAAMCuartas/SCAAMAmalgamatedTerminal.lua');
Script.LoadScript('Scripts/Entities/SCAAMCuartas/SCAAMAmalgamatedTerminalManager.lua');
Script.LoadScript('Scripts/Entities/SCAAMCuartas/SCAAMGameFloppyDisk.lua');
Script.LoadScript('Scripts/Entities/SCAAMCuartas/SCAAMAppFloppyDisk.lua');
Script.LoadScript('Scripts/Entities/SCAAMCuartas/SCAAMShovel.lua');
Script.LoadScript('Scripts/Entities/SCAAMCuartas/SCAAMStashCrate.lua');

-- Validating if Miscreated:RevivePlayer is set
if not (Miscreated.RevivePlayer) then
    Miscreated.RevivePlayer = function (self, playerId)
        Log('SCAAMAmalgamatedTerminal >> Setting a generic Miscreated:RevivePlayer to make it exist');
    end
end

-- SCAAMATLoadCode
-- Loads de code from a file
function SCAAMATLoadCode()
    if (CryAction.IsDedicatedServer()) then
        local SCAAMATConfigFile = io.open('./SCAAMModCode/SCAAMATConfigCode.txt');

        if (SCAAMATConfigFile) then
            Log('SCAAMAmalgamatedTerminal >> Found code config file');
            for line in SCAAMATConfigFile:lines() do
                local ConfigCode = loadstring(line);
                ConfigCode();
                Log('SCAAMAmalgamatedTerminal >> Executed ConfigCode');
            end

            SCAAMATConfigFile:close();
        else
            Log("SCAAMAmalgamatedTerminal >> Didn't find code config file");
        end
    end
end

-- JSON variable
SCAAMATJSON = nil;

-- Amalgamated Terminal Manager entity
SCAAMATManager = nil;

-- Client amalgamated terminal manager instance
SCAAMATLocalManager = nil;

-- Terminal loadout config
SCAAMATTerminalTable = nil;
SCAAMATMessagesTable = nil;
SCAAMATAppsTable = nil;
SCAAMATPermissionsTable = nil;
SCAAMATMarketTable = nil;
SCAAMATMarketIndex = nil; -- This is the table containing the market data coming from the SCAAMATMarketTable collection
SCAAMATPlayerMarketTable = nil;
SCAAMATStorageTable = nil;
SCAAMATParamsTable = nil;

-- Local terminal id accessed
SCAAMATTerminalId = 0;
SCAAMATTerminalSteamId = 0;

-- Item names and classname tables
SCAAMATClassToName = nil;
SCAAMATNameToClass = nil;
SCAAMATSelectionData = {};

-- Accessed terminal tables
SCAAMATAccessedTerminals = {};

-- Smart table for the UI
SCAAMATUIFunctions = {};

-- Anti trade spam table
SCAAMATCurrentTrades = {};

-- Filtered item table
SCAAMATFilterTable = {};

-- Connected entities table
SCAAMATEntitiesConnected = {};

-- Client messages table
SCAAMATLoadedMessages = nil;

-- Accessed terminal entity id
SCAAMATAccessedTerminalId = nil;

-- Accessed floppy disk entity id
SCAAMATAccessedFloppyDiskId = nil;

-- Camera parts on client
SCAAMATCameraParts = {};

-- Camera check timer
SCAAMATCameraTimerId = nil;

-- Current selected camera and direction
SCAAMATSelectedCamera = nil;
SCAAMATSelectedCameraPosDir = nil;

-- Map information
SCAAMATMapName = '';
SCAAMATMapScale = 0;

-- Stash contents
SCAAMATStashCoordinates = {};

-- Decrypted message string
SCAAMATDecryptedMessage = '';

-- Stash digging anti spam
SCAAMATIsSomeoneDigging = false;

-- Checker for terminal changes on permissions or background
SCAAMATTerminalChanged = false;

-- Terminal data local variable
SCAAMATTerminalData = nil;

-- Valid surfaces to put the stashes on
SCAAMATValidSurfaces = {
    'mat_soil', 'mat_sand', 'mat_grass', 'mat_gravel', 'mat_mud'
};

-- Randomized dialogs
SCAAMATConsoleDialogs = {
    greeting = {
        'Hey ', 'Hi ', 'Hello ', 'Greetings ', 'Good day ', 'Mr. ', 'Mrs. ', ''
    },
    title = {
        'Colonel', 'General', 'Lieutenant', 'Sergeant', 'Captain', 'Major'
    },
    firstname = {
        'Mary', 'Patricia', 'Jennifer', 'Susan', 'Margaret', 'Sarah', 'Madison', 'Sophia',
        'Emma', 'Elizabeth', 'Megan', 'Lauren', 'Jessica', 'Isabella', 'Emily', 'Olivia',
        'Eva', 'Shelly', 'Amy', 'Aspen', 'Audrey', 'Bailey', 'Alexandra', 'Alice', 'Allie',
        'Alyson', 'Amanda', 'Bianca', 'Angelina', 'Annie', 'April', 'Vanessa', 'Veronica',
        'Tina', 'Wendy', 'Winter', 'Zoey', 'Samantha', 'Ronnie', 'Roxanne', 'Sofia',
        'Stacey', 'Stella', 'Sydney', 'Sylvia', 'Michelle', 'Mikaela', 'Millie', 'Miranda',
        'Monika', 'Rachel', 'Nancy', 'Naomi', 'Natalie', 'Rebecca', 'Kara', 'Katie',
        'Katherine', 'Kimberly', 'Marlow', 'Lacey', 'Jean', 'Jenna', 'Jenny',
        'Amelia', 'Joseph', 'Richard', 'David', 'Robert', 'John', 'Ethan', 'Michael',
        'Daniel', 'Joe', 'Kyle', 'Jake', 'William', 'James', 'Oscar', 'George', 'Thomas',
        'Charlie', 'Jacob', 'Harry', 'Jack', 'Oliver', 'Jeffrey', 'Rick', 'Terry', 'Alex',
        'Charles', 'Freddy', 'Jerry', 'Matthew', 'Brayden', 'Lucas', 'Lenny', 'Ely', 'Tony',
        'August', 'Barret', 'Allan', 'Bill', 'Anthony', 'Bobby', 'Archie', 'Tex', 'Victor',
        'Tommy', 'Wade', 'Tom', 'Wayne', 'Warren', 'Will', 'Tyler', 'Sam', 'Sebastian', 'Roy',
        'Russell', 'Simon', 'Steve', 'Tanner', 'Taylor', 'Chris', 'Pattrick', 'Paul', 'Peter',
        'Noah', 'Logan'
    },
    lastname = {
        'Johnson', 'Miller', 'Davis', 'Garcia', 'Rodriguez', "O'Brien", 'Murphy', 'Roberts',
        'Thomas', 'Evans', 'Wilson', 'Taylor', 'Brown', 'Williams', 'Jones', 'Smith',
        'Price', 'Connors', 'Sawyer', 'Thompson', 'Stone', 'Barksdale', 'Barnes', 'Carter',
        'Jackson', 'Morgan', 'Cooper', 'Rose', 'White', 'Collins', 'Ford', 'Andrews', 'Haywood',
        'Stevens', 'Anderson', 'Schmidt', 'Oakes', 'Bishop', 'Nexus', 'Irvine', 'Reynolds',
        'Harris', 'Fox', 'Rogers', 'Hayes', 'Kates', 'Moore', 'Leonard', 'Murdock', 'Adams',
        'Harper', 'Sheppard', 'Clifford', 'Walker', 'Carver', 'Freeman', 'Parker'
    },
    message = {
        {
            'HighTierGuns',
            "Creo que me gané la lotería amigo. En una de mis carreras encontré el mejor hardware de todos los tiempos. Sin embargo, es un poco extraño, estaba en uno de estos autos al azar atascados en un atasco, sin logotipos ni colores identificativos, es como si hubiera estado allí desde que comenzó la infección. De todos modos, los escondí en una de estas cajas especiales, ya sabes como hacerlo, debes encontrar las coordenadas ",
            ". Los dejaré allí hasta que encontremos un lugar más seguro, donde sepamos que no nos volverán a asaltar uno de estos locos cabrones. Hablamos mañana más tarde."
        },
        {
            'NormalGuns',
            "Sé que no voy a sobrevivir a esto, las heridas son demasiado profundas y cada día me enfermo más. Realmente aprecio tu esfuerzo por encontrar algo o alguien que me ayude a sobrevivir, pero creo que es demasiado tarde para mí. Obtuve toda la fuerza que tenía y escondí todas mis posesiones importantes cerca de este campamento para que no lo tomen los saqueadores, las coordenadas son",
            ". Espero que esto pueda ayudarlo en su camino a Hayward Valley y finalmente encuentre refugio en Amalgamated. Por favor, sobrevive ... haz eso por mí, ¿de acuerdo?"
        },
        {
            'BuildingSupplies',
            "¡ME VOY! No sé ustedes, pero estoy cansado de esta mierda, Amalgamated no está haciendo nada por nosotros, y yo a cambio estoy construyendo estas cosas raras para ellos que ni siquiera sirven como refugio. ¡Que se jodan! Me voy para siempre y le voy a pedir al tipo que conocimos de la otra colonia el otro día que me quite el chip, todo es una conspiración, no nos impide convertirnos en mutantes, no creo tal cosa. De todos modos, voy a ir con mis materiales de construcción a las coordenadas.",
            " para construir mi propia base que realmenteusaremos, todos son bienvenidos a unirse a mí.."
        },
        {
            'GeneralSupplies',
            "Creo que reuní suficientes suministros para mi hijo, debería estar lo suficientemente seguro como para estar con nosotros en este movimiento, todavía me niego a darle un arma, aún no es el momento, pero hay algunas cosas de alta calidad allí. Regresaré en 2 días, pero coloqué un alijo en las coordenadas",
            ". Eso es entre el refugio y donde estoy, para ti debería ser una caminata de 25 minutos, ni remotamente cerca del nido. Ve con él y enséñale un poco del mundo exterior. Necesitará aprender todo lo que pueda antes de partir.."
        },
        {
            'HighTierGuns',
            "Ni siquiera sé cómo estoy encriptando este mensaje, todavía estoy en estado de shock. De alguna manera sobreviví a un gran tiroteo entre Amalgamated y la gente de Iron Sons, pude esconderme en un arbusto y tuve suerte de que no me atrapara una bala. Pude recuperar algunas cosas realmente agradables de los cuerpos, esto debería ser suficiente para protegernos. Regreso mañana, por ahora cava un hoyo en las coordenadas",
            " porque no planeo compartir todo esto con los demás, te lo contaré todo cuando regrese, pero por ahora, ten cuidado con esta chica 'ex-cia'."
        },
        {
            'NormalGuns',
            "Muy bien, no quiero decirte cómo hacer tu trabajo, pero ¿podrías establecer tus prioridades en orden? Sé que es difícil estar a cargo de un grupo grande, pero realmente necesitamos entrenamiento de combate. Ya perdimos dos, ese nido debe desaparecer. Encontré algunas armas y municiones en un coche de policía, pero las guardé en las coordenadas.",
            " Por lo que no dejes que nadie entre. En serio, no podemos seguir esperando a que Amalgamated nos recoja, tenemos que aprender a defendernos."
        },
        {
            'HighTierGuns',
            "El trato salió como se esperaba, 3 semanas de suministros de alimentos, pero ahora tenemos suficiente hardware para repeler a los bandidos y déjame decirte, ¡es bastante bueno! Toma nota de las coordenadas",
            ". Vamos a sellar el trato allí mismo, por favor no lo arruines esta vez."
        },
        {
            'GeneralSupplies',
            "¿Recuerdas esos libros que hablan sobre teorías de la conspiración en los días normales en los que nunca vivimos? Los Hijos de Hierro parecen ser este tipo de personas conspiranoicas. Nunca he visto ni experimentado una mala interacción con los chicos de Amalgamated, y siguen construyendo y creando cosas útiles para nuestra supervivencia. Dejé el asentamiento ya en muy buenos términos con el comandante en realidad, incluso me dieron un buen caché de equipo. Realmente no necesito todo esto, así que guardé la mitad en las coordenadas",
            " En caso de que lo necesites, a veces iré a ver cómo estás, por ahora, si te sientes cómodo allí, puedes quedarte, no te estoy obligando a ti ni a nadie más a unirse a mí, simplemente no les digas que me dirijo hacia Amalgamated.."
        },
        {
            'BuildingSupplies',
            "Este grupo no peleó, esa es la primera vez. Sin sangre ni balas desperdiciadas, nos van a proporcionar material de construcción semanal en las coordenadas",
            ". Sin embargo, tenga en cuenta que algunos de ellos o los propios no están siendo lo suficientemente cuidadosos y los militares se están enterando de nuestros parches y colores, no estoy seguro de si tienen algún nombre, debemos tener más cuidado, cubrir nuestras huellas y luego encontrar y deshacerse de esos idiotas. tratando de delatarnos. Demasiadas personas que intentan jugar al héroe, no saben lo que les espera."
        },
    },
    messageFormal = {
        {
            'HighTierGuns',
            "La situación en Hayward está empeorando, los soldados fusionados se han apoderado de la mitad de la ciudad y la radio anthena está comprometida, necesitamos refuerzos lo antes posible. Sabemos que la situación del suministro no es buena en Sultan, pero no se preocupe, solo necesitamos mano de obra. Preparamos un alijo en preparación para esta situación, está ubicado en las coordenadas",
            ". Solo podemos esperar un par de días antes de que tomen toda la ciudad, y ya sabes lo que significa perder a Hayward, contamos contigo."
        },
        {
            'HighTierGuns',
            "Como comentamos ayer, estamos preparando un ataque a un búnker, el plan de acción se determinarán cuando nos encontremos en el punto de encuentro. Sé que esto debería haber sido discutido en el cuartel general, pero no podemos arriesgarnos a filtraciones, especialmente desde que nos enteramos de informantes internos en nuestras filas, por ahora, debes equipar a tu equipo con las mejores armas que podamos tener, hay un escondite en coordenadas",
            " y no debería ser difícil para usted reunir activos confiables para esta operación. Estaremos publicados en el punto de encuentro entre las 7 p.m. y las 11 p.m. para que tengas suficiente tiempo."
        },
        {
            'HighTierGuns',
            "Los preparativos están listos, este desertor de Amalgamated ha demostrado ser bastante útil. Coordenadas del alijo de armas en",
            ". Su prueba de fuego será que mate a su superior, no te preocupes, solo la hemos llevado a nuestros asentamientos falsos, por lo que no hay información útil que pueda darles si de repente se pone en contacto con nosotros. Mi única preocupación es la posibilidad de un montaje, hemos enviado gente a explorar el área, esperando recibir una palabra de ellos. Trae a Amelia, si alguien es capaz de atrapar a alguien mintiendo es ella."
        },
        {
            'NormalGuns',
            "La gente está realmente molesta en Pinecrest, la ciudad está siendo invadida todas las noches por mutantes, no sé realmente de dónde vienen, así que tenemos que encontrar la fuente del problema, reuní algunos suministros en las coordenadas.",
            ". No es el mejor armamento que existe, pero no deberíamos necesitar más poder para el nido de un mutante. Espero que sea consciente de la importancia de estas pequeñas operaciones, necesitamos personas de nuestro lado, para nuestra causa y no sería demasiado ideal para verlos volver a lavarse el cerebro con Amalgamated, solo porque no nos ocupamos de tales una tarea sencilla. Ven a verme en 2 horas."
        },
        {
            'NormalGuns',
            "La operación de incursión fue un éxito, pero la información no fue tan precisa como esperábamos. Este convoy solo tenía armas civiles, creemos que se estaban utilizando para entrenamiento. Sí, ahora están entrenando a civiles para ir contra los Hijos de Hierro. Las armas están en el lugar habitual, coordenadas.",
            ". Esto es realmente malo si me preguntas, ya que luchar contra civiles va en contra de nuestro código moral, por lo que debemos coordinar un plan de acción lo antes posible. Encuentro en 'C-34' en 30"
        },
        {
            'NormalGuns',
            "La capacitación de los nuevos reclutas ha comenzado, las pruebas psicológicas parecen estar bien, creo que casi todos tienen rencor con Amalgamated, por lo que la motivación está en su lugar. No creo que necesitemos redoblar la seguridad esta vez. En 5 días realizaremos simulaciones en H-6, para ser más específicos, coordenadas",
            ". Pídale a uno de sus cadetes que ponga un alijo de armas civiles, espero que los reclutas estén listos para esa fase cuando llegue ese día."
        },
        {
            'BuildingSupplies',
            "Para continuar con los refuerzos del asentamiento, hemos escondido algunos suministros cerca de la estación, coordenadas",
            ". Necesita saber de usted o del ingeniero sobre el tiempo de finalización, algunas personas se están poniendo ansiosas al dormir en estos espacios reducidos"
        },
        {
            'BuildingSupplies',
            "Hemos terminado de construir lo que pidió de acuerdo con sus requisitos, una solicitud realmente extraña, puedo decir, pero si ayuda al grupo, estamos de acuerdo. No necesitábamos usar todos los materiales, por lo que los hemos colocado en un escondite, ubicado en las coordenadas.",
            ". Tenga en cuenta que no pudimos traerlos con nosotros porque el camión está varado y necesita reparaciones urgentes, así que envíe a alguien por los suministros y al mecánico para reparar el vehículo."
        },
        {
            'GeneralSupplies',
            "¿Qué es esto que escucho de algunas personas? ¿Este estúpido cadete tuyo sigue negándose a colocar escondites porque no le gusta cavar, perra perezosa? ¿Le has explicado alguna vez que esta es la única forma de no ser rastreado por Amalgamated? Aquí, dile que guarde una caja de equipo en las coordenadas.",
            ". Le daré otro alijo cuando termine. No lo dejaré descansar un solo minuto, o aprende cómo contribuir a la causa, ¡o puede ir a obtener su lobotomía gratis en Amalgamated Labs!"
        },
        {
            'GeneralSupplies',
            "El Amalgatracker que robamos está recibiendo una señal de un alijo de suministros de generación antigua en algún lugar cerca de las coordenadas",
            ". Pueden ser armas, materiales o equipos, sea lo que sea, no podemos ser exigentes al respecto en este momento. Envíe un escuadrón de reconocimiento y contácteme con lo que encontraron."
        },
        {
            'BuildingSupplies',
            "El Amalgatracker que robamos está recibiendo una señal de un alijo de suministros de generación antigua en algún lugar cerca de las coordenadas",
            ". Pueden ser armas, materiales o equipos, sea lo que sea, no podemos ser exigentes al respecto en este momento. Envíe un escuadrón de reconocimiento y contácteme con lo que encontraron."
        },
        {
            'NormalGuns',
            "El Amalgatracker que robamos está recibiendo una señal de un alijo de suministros de generación antigua en algún lugar cerca de las coordenadas",
            ". Pueden ser armas, materiales o equipos, sea lo que sea, no podemos ser exigentes al respecto en este momento. Envíe un escuadrón de reconocimiento y contácteme con lo que encontraron."
        },
        {
            'HighTierGuns',
            "El Amalgatracker que robamos está recibiendo una señal de un alijo de suministros de generación antigua en algún lugar cerca de las coordenadas",
            ". Pueden ser armas, materiales o equipos, sea lo que sea, no podemos ser exigentes al respecto en este momento. Envíe un escuadrón de reconocimiento y contácteme con lo que encontraron."
        }
    }
};

-- Possible stash contents
SCAAMStashContents = {
    RandomPrimaryWeapon = {
        RandomRifle = {
            {Item = 'AK5D', Ammo = {'556x30_ak5d', 'ext_556x75'}, Attachment1 = {'T1Micro', 'ReflexSight'}, Spawner = 'HighTierGuns'},
            {Item = 'AK74U', Ammo = {'545x30'}, Attachment1 = {'ReddotSight', 'T1Micro', 'OPKSight', 'R3Sight', 'ReflexSight', 'OpticScope'}, Attachment2 = {'ForegripVertical', 'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'AKM', Ammo = {'762x30', 'ext_762x75'}, Attachment1 = {'ReddotSight', 'OPKSight', 'R3Sight', 'T1Micro', 'ReflexSight', 'OpticScope'}, Attachment2 = {'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'AKMGold', Ammo = {'762x30', 'ext_762x75'}, Attachment1 = {'ReddotSight', 'OPKSight', 'R3Sight', 'T1Micro', 'ReflexSight'}, Attachment2 = {'LaserSight'}, Spawner = 'HighTierGuns'},
            {Item = 'AKVal', Ammo = {'762x20_Akval', 'ext_762x30'}, Attachment1 = {'ReddotSight', 'OPKSight', 'R3Sight', 'T1Micro', 'ReflexSight', 'OpticScope'}, Spawner = 'HighTierGuns'},
            {Item = 'AT15', Ammo = {'STANAGx30', 'STANAGx50','ext_556x75'}, Attachment1 = {'ReddotSight', 'OPKSight', 'R3Sight', 'T1Micro', 'ReflexSight', 'OpticScope'}, Attachment2 = {'ForegripVertical', 'RifleSilencer'}, Spawner = 'HighTierGuns,NormalGuns'},
            {Item = 'Bulldog', Ammo = {'STANAGx30', 'STANAGx50', 'ext_556x75'}, Spawner = 'HighTierGuns'},
            {Item = 'M4A1', Ammo = {'STANAGx30','STANAGx50', 'ext_556x75'}, Attachment1 = {'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'M4V5', Ammo = {'STANAGx30','STANAGx50', 'ext_556x75'}, Attachment1 = {'ReddotSight', 'OPKSight', 'R3Sight', 'T1Micro', 'ReflexSight', 'OpticScope'}, Attachment2 = {'ForegripVertical', 'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'M16', Ammo = {'STANAGx30', 'STANAGx50','ext_556x75'}, Attachment1 = {'T1Micro', 'OPKSight', 'R3Sight', 'ReflexSight', 'OpticScope', 'HuntingScope', 'ReddotSight'}, Attachment2 = {'ForegripVertical', 'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'M16Vietnam', Ammo = {'STANAGx30','STANAGx50', 'ext_556x75'}, Attachment1 = {'BayonetRifle', 'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'M249', Ammo = {'556x100'}, Attachment1 = {'BayonetRifle', 'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'Mk18', Ammo = {'STANAGx30', 'STANAGx50','ext_556x75'}, Attachment1 = {'T1Micro', 'OPKSight', 'R3Sight', 'ReflexSight', 'OpticScope', 'ReddotSight'}, Attachment2 = {'LaserSight', 'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'Mk18Reaver', Ammo = {'STANAGx30', 'STANAGx50','ext_556x75'}, Attachment1 = {'T1Micro', 'ReflexSight', 'OpticScope', 'OPKSight', 'R3Sight', 'ReddotSight'}, Attachment2 = {'LaserSight', 'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'RPK', Ammo = {'762x30', 'ext_762x75'}, Attachment1 = {'PSOScope'}, Attachment2 = {'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'VSS', Ammo = {'762x20_Akval', 'ext_762x30'}, Attachment1 = {'PSOScope'}, Spawner = 'HighTierGuns'}
        },
        RandomShotgun = {
            {Item = 'AA12', Ammo = {'12Gaugex8_Beanbag_AA12', '12Gaugex8_Pellet_AA12', '12Gaugex8_Slug_AA12'}, Spawner = 'HighTierGuns'},
            {Item = 'Rem870', Ammo = {'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'}, Spawner = 'HighTierGuns,NormalGuns'},
            {Item = 'SAS12', Ammo = {'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'}, Attachment1 = {'T1Micro', 'OPKSight', 'R3Sight', 'ReflexSight', 'ReddotSight'}, Attachment2 = {'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'Shotgun870Tactical', Ammo = {'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'}, Attachment1 = {'T1Micro', 'OPKSight', 'R3Sight', 'ReflexSight', 'ReddotSight'}, Attachment2 = {'RifleSilencer'}, Spawner = 'HighTierGuns,NormalGuns'}
        },
        RandomBoltAction = {
            {Item = 'ACAW', Ammo = {'762x5'}, Attachment1 = {'OpticScope', 'HuntingScope', 'OPKSight', 'R3Sight', 'ReddotSight', 'ReflexSight', 'T1Micro'}, Attachment2 = {'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'M40A5', Ammo = {'M40x5'}, Attachment1 = {'OpticScope', 'HuntingScope', 'OPKSight', 'R3Sight', 'ReddotSight', 'ReflexSight', 'T1Micro'}, Attachment2 = {'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'Model70', Ammo = {'Pile_223'}, Attachment1 = {'OpticScope', 'HuntingScope', 'OPKSight', 'R3Sight', 'ReddotSight', 'ReflexSight', 'T1Micro'}, Attachment2 = {'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'Model1873', Ammo = {'Pile_357'}, Spawner = 'HighTierGuns'},
            {Item = 'Rem700', Ammo = {'Pile_308'}, Attachment1 = {'OpticScope', 'HuntingScope', 'OPKSight', 'R3Sight', 'ReddotSight', 'ReflexSight', 'T1Micro'}, Attachment2 = {'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'Sako_85', Ammo = {'Pile_308'}, Attachment1 = {'OpticScope', 'HuntingScope', 'OPKSight', 'R3Sight', 'ReddotSight', 'ReflexSight', 'T1Micro'}, Attachment2 = {'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'Wasteland22', Ammo = {'Pile_22'}, Spawner = 'HighTierGuns,NormalGuns'}
        },
        RandomSMG = {
            {Item = 'AUMP45', Ammo = {'acp_45x30'}, Attachment1 = {'T1Micro', 'ReflexSight', 'OPKSight', 'R3Sight', 'OpticScope', 'ReddotSight'}, Attachment2 = {'LaserSight', 'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'CX4Storm', Ammo = {'acp_45x20'}, Attachment1 = {'T1Micro', 'ReflexSight', 'OPKSight', 'R3Sight', 'OpticScope', 'ReddotSight'}, Attachment2 = {'ForegripVertical', 'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'KrissV', Ammo = {'10mmx15'}, Attachment1 = {'T1Micro', 'OPKSight', 'R3Sight', 'ReflexSight', 'ReddotSight', 'OpticScope'}, Attachment2 = {'ForegripVertical', 'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'MAK10', Ammo = {'9x19_mac10'}, Attachment1 = {'PistolSilencer'}, Spawner = 'HighTierGuns,NormalGuns'},
            {Item = 'MP5', Ammo = {'10mmx30'}, Attachment1 = {'ReddotSight', 'OPKSight', 'R3Sight', 'T1Micro', 'ReflexSight', 'OpticScope'}, Attachment2 = {'RifleSilencer'}, Spawner = 'HighTierGuns'},
            {Item = 'R90', Ammo = {'57x50'}, Attachment1 = {'T1Micro', 'OPKSight', 'R3Sight', 'ReflexSight', 'ReddotSight', 'OpticScope'}, Attachment2 = {'LaserSight', 'RifleSilencer'}, Spawner = 'HighTierGuns'}
        }
    },
    RandomSecondaryWeapon = {
        RandomShotgun = {
            {Item = 'SawedShotgun', Ammo = {'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'}, Spawner = 'NormalGuns'},
            {Item = 'CraftedShortShotgun_jack', Ammo = {'Pile_12GaugeSlug'}, Spawner = 'NormalGuns'}
        },
        RandomPistol = {
            {Item = 'AP85', Ammo = {'9mmx19_ap85'}, Spawner = 'NormalGuns'},
            {Item = 'ColtPython', Ammo = {'Pile_357'}, Spawner = 'NormalGuns'},
            {Item = 'ColtPythonGrimeyRick', Ammo = {'Pile_357'}, Spawner = 'NormalGuns,HighTierGuns'},
            {Item = 'G18Pistol', Ammo = {'9mmx10', '9mmx19', '9mmx33'}, Attachment1 = {'PistolSilencer'}, Spawner = 'NormalGuns'},
            {Item = 'hk45', Ammo = {'acp_45x10_hk'}, Spawner = 'NormalGuns'},
            {Item = 'M9A1', Ammo = {'9mmx15_m9a1'}, Attachment1 = {'PistolSilencer'}, Spawner = 'NormalGuns'},
            {Item = 'm1911a1', Ammo = {'acp_45x7'}, Attachment1 = {'PistolSilencer'}, Spawner = 'NormalGuns'},
            {Item = 'Makarov', Ammo = {'9mmx10_makarov'}, Attachment1 = {'PistolSilencer'}, Spawner = 'NormalGuns'},
            {Item = 'P350', Ammo = {'357x14'}, Attachment1 = {'PistolSilencer'}, Spawner = 'NormalGuns,HighTierGuns'},
            {Item = 'Peacemaker', Ammo = {'Pile_357'}, Spawner = 'NormalGuns'},
            {Item = 'PX4', Ammo = {'acp_45x10_hk'}, Attachment1 = {'PistolSilencer'}, Spawner = 'NormalGuns'},
            {Item = 'ruger22', Ammo = {'22x10_ruger'}, Spawner = 'NormalGuns'}
        },
        RandomMelee = {
            {Item = 'Axe', Spawner = 'NormalGuns'},
            {Item = 'AxePatrick', Spawner = 'NormalGuns,HighTierGuns'},
            {Item = 'BaseballBat', Spawner = 'NormalGuns'},
            {Item = 'BaseballBatHerMajesty', Spawner = 'NormalGuns,HighTierGuns'},
            {Item = 'BaseballBatNails', Spawner = 'NormalGuns'},
            {Item = 'BaseballBatSawBlade', Spawner = 'NormalGuns'},
            {Item = 'BaseballBatSawBladeNails', Spawner = 'NormalGuns'},
            {Item = 'BaseballBatScrapNails', Spawner = 'NormalGuns'},
            {Item = 'Crowbar', Spawner = 'NormalGuns'},
            {Item = 'Katana', Spawner = 'NormalGuns,'},
            {Item = 'KatanaBlackWidow', Spawner = 'NormalGuns,HighTierGuns'},
            {Item = 'Sledgehammer', Spawner = 'NormalGuns,HighTierGuns'},
            {Item = 'FahQPaddle', Spawner = 'NormalGuns'},
            {Item = 'Cleaver', Spawner = 'NormalGuns'},
            {Item = 'Hatchet', Spawner = 'NormalGuns'},
            {Item = 'HuntingKnife', Spawner = 'NormalGuns'},
            {Item = 'LugWrench', Spawner = 'NormalGuns'},
            {Item = 'Machete', Spawner = 'NormalGuns'},
            {Item = 'NailKnuckles', Spawner = 'NormalGuns'},
            {Item = 'NailsPaddle', Spawner = 'NormalGuns'},
            {Item = 'PipeWrench', Spawner = 'NormalGuns'},
            {Item = 'PoliceBaton', Spawner = 'NormalGuns'},
            {Item = 'SurvivalKnife', Spawner = 'NormalGuns'}
        }
    },
    RandomUtilitary = {
        RandomExplosive = {
            {Item = 'FlashbangPickup', Spawner = 'NormalGuns'},
            {Item = 'GrenadeGasNervePickup', Spawner = 'NormalGuns'},
            {Item = 'GrenadeGasSleepPickup', Spawner = 'NormalGuns,GeneralSupplies'},
            {Item = 'GrenadeGasTearPickup', Spawner = 'NormalGuns'},
            {Item = 'GrenadePickup', Spawner = 'HighTierGuns'},
            {Item = 'GrenadeSmokeWhitePickup', Spawner = 'NormalGuns,GeneralSupplies'},
            {Item = 'PipebombPickup', Spawner = 'HighTierGuns'},
            {Item = 'GrenadeMolotovPickup', Spawner = 'NormalGuns,GeneralSupplies'}
        },
        RandomMedical = {
            {Item = 'Bandage', Spawner = 'GeneralSupplies'},
            {Item = 'AntibioticBandage', Spawner = 'GeneralSupplies'},
            {Item = 'AdvancedBandage', Spawner = 'GeneralSupplies'},
            {Item = 'AntiradiationPills', Spawner = 'GeneralSupplies'},
            {Item = 'Antibiotics', Spawner = 'GeneralSupplies'}
        }
    },
    RandomStorage = {
        {Item = 'StowPackBlack', Spawner = 'GeneralSupplies'},
        {Item = 'RuggedPack', Spawner = 'GeneralSupplies'},
        {Item = 'FannyPackBlack', Spawner = 'GeneralSupplies'},
        {Item = 'horshoe_pack', Spawner = 'GeneralSupplies'},
        {Item = 'GasCanisterPack', Spawner = 'GeneralSupplies'},
        {Item = 'DuffelBag', Spawner = 'GeneralSupplies'}
    },
    RandomProtection = {
        RandomChest = {
            {Item = 'FlakVestTan', Spawner = 'GeneralSupplies'},
            {Item = 'PoliceVestBlack', Spawner = 'GeneralSupplies'},
            {Item = 'TacticalVestBlack', Spawner = 'GeneralSupplies'},
            {Item = 'GhillieSuit1', Spawner = 'GeneralSupplies'},
            {Item = 'GhillieSuit2', Spawner = 'GeneralSupplies'},
            {Item = 'GhillieSuit3', Spawner = 'GeneralSupplies'},
            {Item = 'GhillieSuit4', Spawner = 'GeneralSupplies'}
        },
        RandomHead = {
            {Item = 'SpaceHelmet', Spawner = 'GeneralSupplies'},
            {Item = 'SwatHelmet', Spawner = 'GeneralSupplies'},
            {Item = 'ScavengerHelmet', Spawner = 'GeneralSupplies'},
            {Item = 'MotorcycleHelmetCarbon', Spawner = 'GeneralSupplies'},
            {Item = 'MilitaryHelmetTan', Spawner = 'GeneralSupplies'},
            {Item = 'GhillieHood1', Spawner = 'GeneralSupplies'},
            {Item = 'GhillieHood2', Spawner = 'GeneralSupplies'},
            {Item = 'GhillieHood3', Spawner = 'GeneralSupplies'},
            {Item = 'GhillieHood4', Spawner = 'GeneralSupplies'}
        }
    },
    RandomBuilding = {
        {Item = 'Lumber', Spawner = 'BuildingSupplies'},
        {Item = 'Nails', Spawner = 'BuildingSupplies,GeneralSupplies'},
        {Item = 'IronOre', Spawner = 'BuildingSupplies'},
        {Item = 'IronIngot', Spawner = 'BuildingSupplies,GeneralSupplies'},
        {Item = 'Tarp', Spawner = 'BuildingSupplies'},
        {Item = 'SheetMetal', Spawner = 'BuildingSupplies'},
        {Item = 'ScrapMetal', Spawner = 'BuildingSupplies'},
        {Item = 'PaintCan_Yellow', Spawner = 'BuildingSupplies'},
        {Item = 'PaintCan_White', Spawner = 'BuildingSupplies'},
        {Item = 'PaintCan_Red', Spawner = 'BuildingSupplies'},
        {Item = 'PaintCan_Green', Spawner = 'BuildingSupplies'},
        {Item = 'PaintCan_Blue', Spawner = 'BuildingSupplies'},
        {Item = 'PaintCan_Black', Spawner = 'BuildingSupplies'},
        {Item = 'SolarPanelPiece', Spawner = 'BuildingSupplies'}
    }
}

local SCAAMATExistingCategories = {'HighTierGuns', 'NormalGuns', 'GeneralSupplies', 'BuildingSupplies'};
SCAAMATSupplyByCategory = {
    HighTierGuns = {},
    NormalGuns = {},
    GeneralSupplies = {},
    BuildingSupplies = {}
};

-- Build the simplified category table for the stash crate spawner
for key, value in pairs(SCAAMATExistingCategories) do
    for key2, value2 in pairs(SCAAMStashContents) do
        for key3, value3 in pairs(value2) do
            if (value3.Item and string.match(value3.Spawner, value)) then
                table.insert(SCAAMATSupplyByCategory[value], value3);
            else
                for key4, value4 in pairs(value3) do
                    if (value4.Item and string.match(value4.Spawner, value)) then
                        table.insert(SCAAMATSupplyByCategory[value], value4);
                    end
                end
            end
        end
    end
end

-- Pre-existing apps and backgrounds for this mod
SCAAMATApps = {
    {'appSurveillance', 'Cameras'},
    {'appIronSons', 'Unknown'},
    {'appGames', 'Games'}
};

SCAAMATGames = {
	{'pingpong', 'pingpong'},
	{'pacman', 'pacman'},
	{'space-invaders', 'space invaders'},
	{'arkanoid-classic', 'arkanoid classic'},
	{'snake', 'snake'},
	{'test-your-mouse', 'test your mouse'}
};

SCAAMATScreenBackgrounds = {
	'amalgamatedbg',
	'blackholebg',
	'digitalbg',
	'earthbg',
	'fiberbg',
	'futurebg',
	'inceptionbg',
	'voidbg',
	'wavesbg',
	'wavestwobg'
};

-- Special data saved in some custom entities
SCAAMATItemSpecialData = {
    SCAAMAmalgamatedNotebook = {
        varName = 'SCAAMNotebookRelevanceID',
        description = 'This notebook contains a bunch of empty pieces of paper, x',
        includeValue = true
    },
    SCAAMNotePaper_packed = {
        varName = 'SCAAMNoteRelevanceID',
        description = 'This piece of paper contains a note',
        includeValue = false
    },
    SCAAMGameFloppyDisk = {
        varName = 'SCAAMATAppName',
        description = 'This floppy disk has a game stored in it, label reads: ',
        includeValue = true
    },
    SCAAMAppFloppyDisk = {
        varName = 'SCAAMATAppName',
        description = 'This floppy disk has an application stored in it, label reads: ',
        includeValue = true
    }
};

-- SCAAMATGetRandomGUID
-- Returns a random GUID for something, it makes sure it wasn't assigned already (am I using this?)
function SCAAMATGetRandomGUID(isNote)
    local isUnique = false;

    while (isUnique == false) do
        local random = math.random;
        local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx';
        local randomGUID = string.gsub(template, '[xy]', function(c)
            local v = (c == 'x') and random(0, 0xf) or random(8, 0xb);
            return string.format('%x', v);
        end);

        if ((isNote == true and SCAAMATDatabase:GetPage(randomGUID) == nil) or (isNote == false and SCAAMNotebooksDatabase:GetPage(randomGUID) == nil)) then
            if (SCAAMATGlobalSessionData[randomGUID] == nil) then
                isUnique = true;
                return randomGUID;
            end
        end
    end
end

-- SCAAMATTableEquals
-- Checks if two tables are equal
function SCAAMATTableEquals(o1, o2, ignore_mt)
    if o1 == o2 then return true end
    local o1Type = type(o1)
    local o2Type = type(o2)
    if o1Type ~= o2Type then return false end
    if o1Type ~= 'table' then return false end

    if not ignore_mt then
        local mt1 = getmetatable(o1)
        if mt1 and mt1.__eq then
            --compare using built in method
            return o1 == o2
        end
    end

    local keySet = {}

    for key1, value1 in pairs(o1) do
        local value2 = o2[key1]
        if value2 == nil or SCAAMATTableEquals(value1, value2, ignore_mt) == false then
            return false
        end
        keySet[key1] = true
    end

    for key2, _ in pairs(o2) do
        if not keySet[key2] then return false end
    end
    return true
end

-- SCAAMATCheckUnconsciousness
-- Checks if the player is unconscious after a delay and closes the terminal UI if positive
function SCAAMATCheckUnconsciousness(playerData)
    local player = System.GetEntity(playerData.PlayerId);

    if (player.player:IsUnconcious() or player.player:GetTorpidity() > 90) then
        SCAAMATSendClientData({dummyData = ''}, 'CloseUI', playerData.PlayerId);
    end
end

-- SCAAMATPreInitModules
-- Manage UI reload stuff
function SCAAMATPreInitModules()
    if (not CryAction.IsDedicatedServer()) then
        Log('SCAAMAmalgamatedTerminal >> Called client UI init from not IsDedicatedServer');
        ReloadModUIOnlyOnce();
    end
end

-- SCAAMATInitModules
-- Manage storage stuff (Based on Theros' mFramework)
function SCAAMATInitModules()
    SCAAMATJSON = require('JSON');

    if (CryAction.IsDedicatedServer()) then
        SCAAMATTerminalTable = mFramework.PersistantStorage:Collection('SCAAMATTerminalTable');
        SCAAMATMessagesTable = mFramework.PersistantStorage:Collection('SCAAMATMessagesTable');
        SCAAMATAppsTable = mFramework.PersistantStorage:Collection('SCAAMATAppsTable');
        SCAAMATPermissionsTable = mFramework.PersistantStorage:Collection('SCAAMATPermissionsTable');
        SCAAMATMarketTable = mFramework.PersistantStorage:Collection('SCAAMATMarketTable');
        SCAAMATMarketIndex = SCAAMATMarketTable:GetPage('ServerMarket');

        -- Checks if the market table exists then defines it if negative
        if (SCAAMATMarketIndex == nil) then
            SCAAMATMarketIndex = {};
            SCAAMATMarketTable:SetPage('ServerMarket', SCAAMATMarketIndex);
        end

        SCAAMATPlayerMarketTable = mFramework.PersistantStorage:Collection('SCAAMATPlayerMarketTable');
        SCAAMATStorageTable = mFramework.PersistantStorage:Collection('SCAAMATStorageTable');

        SCAAMATParamsTable = mFramework.PersistantStorage:Collection('SCAAMATParamsTable');

        -- Checks if the params table exists then defines defailt parameters if negative
        if (SCAAMATParamsTable:GetPage('terminalIdCounter') == nil) then
            SCAAMATParamsTable:SetPage('terminalIdCounter', 1);
            SCAAMATParamsTable:SetPage('marketIdCounter', 1);
            SCAAMATParamsTable:SetPage('messagesIdCounter', 1);
            SCAAMATParamsTable:SetPage('addedGames', {{'placeholder', 'placeholder'}, {'placeholder2', 'placeholder2'}});
            SCAAMATParamsTable:SetPage('addedBackgrounds', {'placeholder', 'placeholder2'});
        end

        -- Performs the operation to reduce id's and to remove expired items in general
        SCAAMATCleanMarketAndStorage();
    else
        SCAAMATInitItemData();
    end
end

-- SCAAMATCleanMarketAndStorage
-- Reduce id's and remove expired items in general market
function SCAAMATCleanMarketAndStorage()
    local newIdCounter = table.getn(SCAAMATMarketIndex);
    local time = System.GetLocalOSTime();

    -- Sets the current date.
    curDateTime = os.time({year = time.year + 1900, month = time.mon + 1, day = time.mday, hour = time.hour, min = time.min, sec = time.sec});

    -- Updates the ids on the market if the item is not removed due to expiration
    for key, value in pairs(SCAAMATMarketIndex) do
        local daysfrom = os.difftime(curDateTime, value.expDate) / (24 * 60 * 60);
        local wholedays = math.floor(daysfrom);

        -- Checks if the items needs to be removed, if not it assigns a new id to the item
        -- and the player market item
        if (wholedays > 0) then
            local playerMarket = SCAAMATPlayerMarketTable:GetPage(tostring(value.terminalId));

            -- Looks for the player market item to move it to storage
            for key2, value2 in pairs(playerMarket) do
                if (value2.id == value.id) then

                    -- Removes the item from the player market for good
                    local removedItem = table.remove(playerMarket, key2);
                    SCAAMATPlayerMarketTable:SetPage(tostring(value.terminalId), playerMarket);

                    -- Call to the function to add the items to the terminal storage
                    local historyText = 'x' .. removedItem.quantity .. ' ' .. ISM.GetItemDisplayName(removedItem.classname) .. ' | Removed from market because it expired';
                    SCAAMATAddExpItemToStorage(removedItem, value.terminalId, historyText);

                    break;
                end
            end

            table.remove(SCAAMATMarketIndex, key);
        else
            local playerMarket = SCAAMATPlayerMarketTable:GetPage(tostring(value.terminalId));

            -- Looks for the player market item to change the id
            for key2, value2 in pairs(playerMarket) do
                if (value2.id == value.id) then

                    -- Changes the player market item id
                    value2.id = newIdCounter;
                    SCAAMATPlayerMarketTable:SetPage(tostring(value.terminalId), playerMarket);

                    break;
                end
            end

            -- Finally changes the id to the market item
            value.id = newIdCounter;
        end

        newIdCounter = newIdCounter - 1;
    end

    newIdCounter = table.getn(SCAAMATMarketIndex) + 1;

    -- Stores the new maximum market id
    SCAAMATParamsTable:SetPage('marketIdCounter', newIdCounter);

    -- Starts process to remove expired storage items
    local maxTerminalId = SCAAMATParamsTable:GetPage('terminalIdCounter') - 1;

    -- Loops through all the terminals to remove the expired items
    for i = 1, maxTerminalId, 1 do
        local storageData = SCAAMATStorageTable:GetPage(tostring(i));

        if (storageData ~= nil) then
            for key, value in pairs(storageData) do

                -- Checks if the item stored is stackable or not to check for expiration dates
                -- appropiately
                if (value.classname) then
                    local daysfrom = os.difftime(curDateTime, value.expDate) / (24 * 60 * 60);
                    local wholedays = math.floor(daysfrom);

                    if (wholedays > 0) then
                        storageData[key] = nil;
                    end
                else
                    for key2, value2 in pairs(value) do
                        local daysfrom = os.difftime(curDateTime, value2.expDate) / (24 * 60 * 60);
                        local wholedays = math.floor(daysfrom);

                        if (wholedays > 0) then
                            table.remove(value, key2);
                        end
                    end

                    if (table.getn(value) <= 0) then
                        storageData[key] = nil;
                    end
                end
            end

            -- Stores the updated data
            SCAAMATStorageTable:SetPage(tostring(i), storageData);
        end
    end
end

-- SCAAMATInitItemData
-- Populates the item data for the UI
function SCAAMATInitItemData(data)

    -- Checks if the name to class array us empty to fill to fill it up
    if (not SCAAMATNameToClass) then
        SCAAMATClassToName = {};
        SCAAMATNameToClass = {};

        for key, item in pairs(_G) do

            -- Checks if the entity is an item
            if (type(item) == 'table' and tostring(ISM.GetItemDisplayName(key)) ~= '') then
                SCAAMATClassToName[key] = ISM.GetItemDisplayName(key);

                if (string.sub(ISM.GetItemDisplayName(key), 1, 1) == '@') then
                    SCAAMATNameToClass[HUD.LocalizeString(ISM.GetItemDisplayName(key))] = key;
                    table.insert(SCAAMATSelectionData, HUD.LocalizeString(ISM.GetItemDisplayName(key)));
                    table.insert(SCAAMATSelectionData, key);
                else
                    SCAAMATNameToClass[ISM.GetItemDisplayName(key)] = key;
                    table.insert(SCAAMATSelectionData, ISM.GetItemDisplayName(key));
                    table.insert(SCAAMATSelectionData, key);
                end
            end
        end

        UIAction.ShowElement('mod_SCAAMAmalgamatedTerminalUI', 0);
        UIAction.SetArray('mod_SCAAMAmalgamatedTerminalUI', 0, 'ItemArray', SCAAMATSelectionData);
        Script.SetTimerForFunction(350, 'SCAAMATFillSelectionDataAfterDelay', {});
    end
end

-- SCAAMATFillSelectionDataAfterDelay
-- Sets the item filter data after a delay
function SCAAMATFillSelectionDataAfterDelay(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FillSelectionData');
    UIAction.HideElement('mod_SCAAMAmalgamatedTerminalUI', 0);
end

-- SCAAMATSendMessage
-- Sends a message to the playerId
function SCAAMATSendMessage(data, playerId)
    g_gameRules.game:SendTextMessage(0, playerId, data.message);
end

-- SCAAMATGetFloppyData
-- Retrieves the floppy data, AKA, the label printed on the item
function SCAAMATGetFloppyData(itemId, playerId)
    local item = System.GetEntity(itemId);
    local labelName = '';

    -- Looks for the readable name from this application or game
    for key, value in pairs(SCAAMATApps) do
        if (value[1] == item.SCAAMATAppName) then
            labelName = value[2];
            break;
        end
    end

    for key, value in pairs(SCAAMATGames) do
        if (value[1] == item.SCAAMATAppName) then
            labelName = value[2]:sub(1, 1):upper() .. value[2]:sub(2);
            break;
        end
    end

    g_gameRules.game:SendTextMessage(0, playerId, 'La etiqueta dice: ' .. labelName);
end

-- SCAAMATGetRandomApp
-- Assigns a random application to a floppy disk
function SCAAMATGetRandomApp()
    return SCAAMATApps[math.random(table.getn(SCAAMATApps))][1];
end

-- SCAAMATGetRandomGame
-- Assigns a random game to a floppy disk
function SCAAMATGetRandomGame()
    return SCAAMATGames[math.random(table.getn(SCAAMATGames))][1];
end

-- SCAAMATGetState
-- Retrieves the state of this terminal
function SCAAMATGetState(itemId, playerId)
    local terminal = System.GetEntity(itemId);
    local player = System.GetEntity(playerId);
    local playerChannel = player.actor:GetChannel();
    local state = 'nouse';

    local plotsign = System.GetNearestEntityByClass(terminal:GetWorldPos(), 600, 'PlotSign');

    -- Checks for the plotsign this terminal is part of
    if (plotsign) then
        local ownerSteamId = plotsign.plotsign:GetOwnerSteam64Id();

        if (SCAAMATAccessedTerminals[ownerSteamId]) then
            local accessPlayer = System.GetEntity(SCAAMATAccessedTerminals[ownerSteamId].playerId);

            if (accessPlayer and accessPlayer.player and accessPlayer.player:GetSteam64Id() == SCAAMATAccessedTerminals[ownerSteamId].steamId) then
                state = 'inuse';

                -- Checks if the player accessing is the same to unlock the access of this terminal, this to prevent it from
                -- locking itself forever when the player that was using it crashed or got disconnected so the measures to unlock
                -- the terminal didn't take place
                if (accessPlayer.player:GetSteam64Id() == player.player:GetSteam64Id()) then
                    state = 'nouse';
                end
            else
                SCAAMATAccessedTerminals[ownerSteamId] = nil;
            end
        end
    end

    terminal.onClient:RestoreActions(playerChannel, state);
end

-- SCAAMATToggleAccessStorage
-- Access the terminal inventory and toggles the access from someone else
function SCAAMATToggleAccessStorage(itemId, playerId, toggle)
    local player = System.GetEntity(playerId);
    local terminal = System.GetEntity(itemId);
    local plotsign = System.GetNearestEntityByClass(terminal:GetWorldPos(), 600, 'PlotSign');

    -- Checks for the plotsign this terminal is part of
    if (plotsign) then
        local ownerSteamId = plotsign.plotsign:GetOwnerSteam64Id();

        -- toggles the access depending on what came from the client function
        if (toggle == 'true') then

            -- Checks if this terminal is not being currently accessed by another player
            if (not SCAAMATAccessedTerminals[ownerSteamId]) then
                SCAAMATAccessedTerminals[ownerSteamId] = {
                    playerId = playerId,
                    steamId = player.player:GetSteam64Id()
                };
            end
        else
            SCAAMATAccessedTerminals[ownerSteamId] = nil;
        end
    end
end

-- SCAAMATAccessTerminal
-- Access the terminal UI with a set of instructions
function SCAAMATAccessTerminal(itemId, playerId)
    local player = System.GetEntity(playerId);
    local terminal = System.GetEntity(itemId);
    local plotsign = System.GetNearestEntityByClass(terminal:GetWorldPos(), 600, 'PlotSign');

    -- Checks for the plotsign this terminal is part of
    if (plotsign) then
        local terminalFinalData = {};
        local steamId = player.player:GetSteam64Id();
        local ownerSteamId = plotsign.plotsign:GetOwnerSteam64Id();
        local ownerClanId = plotsign.plotsign:GetClanId();

        -- Checks if this terminal is not being currently accessed by another player
        if (not SCAAMATAccessedTerminals[ownerSteamId]) then

            -- Checks if the terminal exists in DB, otherwise it creates the first boot data with the default
            -- Apps and settings
            if (SCAAMATTerminalTable:GetPage(ownerSteamId) == nil) then
                local terminalId = SCAAMATParamsTable:GetPage('terminalIdCounter');
                local terminalData = {
                    data = {
                        id = terminalId,
                        name = '',
                        background = 'amalgamatedbg'
                    },
                    apps = {
                        applications = {
                            {'appSettings', 39, 'Settings', 1},
                            {'appTrade', 0, 'Trade', 2},
                            {'appMessages', 1, 'Messages', 3},
                            {'appInstall', 2, 'Install', 1}
                        },
                        games = {
                            {'chess', 'chess'},
                            {'tetris', 'tetris'}
                        }
                    }
                };

                -- Stores the data in DB and additionaly increases the terminal id counter for the next terminal
                SCAAMATTerminalTable:SetPage(ownerSteamId, terminalData.data);
                SCAAMATAppsTable:SetPage(ownerSteamId, terminalData.apps);

                terminalId = terminalId + 1;
                SCAAMATParamsTable:SetPage('terminalIdCounter', terminalId);
            end

            -- This portion returns the terminal app data depending on who is accessing it (the base owner, a clan member or a regular player)
            -- and the settings established by the owner, also sends a flag that says if the player accessing is this terminal owner
            if (steamId == ownerSteamId) then
                terminalFinalData = {
                    data = SCAAMATTerminalTable:GetPage(ownerSteamId),
                    apps = SCAAMATAppsTable:GetPage(ownerSteamId),
                    owner = true
                };
            elseif (ownerClanId and ownerClanId ~= 0 and ownerClanId == player.player:GetClanId()) then
                local customApps = {
                    applications = {},
                    games = SCAAMATAppsTable:GetPage(ownerSteamId).games
                };

                for key, dataItem in pairs(SCAAMATAppsTable:GetPage(ownerSteamId).applications) do
                    if (dataItem[4] == 2 or dataItem[4] == 3) then
                        table.insert(customApps.applications, dataItem);
                    end
                end

                terminalFinalData = {
                    data = SCAAMATTerminalTable:GetPage(ownerSteamId),
                    apps = customApps,
                    owner = false
                };
            else
                local customApps = {
                    applications = {},
                    games = SCAAMATAppsTable:GetPage(ownerSteamId).games
                };

                for key, dataItem in pairs(SCAAMATAppsTable:GetPage(ownerSteamId).applications) do
                    if (dataItem[4] == 3) then
                        table.insert(customApps.applications, dataItem);
                    end
                end

                terminalFinalData = {
                    data = SCAAMATTerminalTable:GetPage(ownerSteamId),
                    apps = customApps,
                    owner = false
                };
            end

            terminalFinalData.steamId = ownerSteamId;
            SCAAMATAccessedTerminals[ownerSteamId] = {
                playerId = playerId,
                steamId = player.player:GetSteam64Id()
            };

            -- Sends the formed terminal data to the client
            SCAAMATSendClientData(terminalFinalData, 'AccessTerminal', playerId);
        else
            g_gameRules.game:SendTextMessage(0, playerId, 'Terminal en uso');
        end
    end
end

-- SCAAMATFreeTerminal
-- Frees the terminal from use so another player can make use of it
function SCAAMATFreeTerminal(data)
    SCAAMATAccessedTerminals[data.steamId] = nil;
end

-- SCAAMATSwitchAppSlots
-- Switches one or more applications to new slots
function SCAAMATSwitchAppSlots(data)
    local apps = SCAAMATAppsTable:GetPage(data.steamId);

    for key, value in pairs(apps.applications) do
        if (value[1] == data.appOneInstance) then
            value[2] = data.appOneSlot;
        end

        if (data.appTwoInstance ~= '' and value[1] == data.appTwoInstance) then
            value[2] = data.appTwoSlot;
        end
    end

    SCAAMATAppsTable:SetPage(data.steamId, apps);
end

-- SCAAMATGetMarketData
-- Gets the market items in a determined page
function SCAAMATGetMarketData(data, playerId)
    local formedPageData = {};
    local marketData = {};
    local maxPages = 1;

    -- Creates or uses a table containing the filtered classname in case one was provided
    if (data.itemFilter ~= '') then
        if (not SCAAMATFilterTable[data.itemFilter]) then
            for key, value in pairs(SCAAMATMarketIndex) do
                if (value.classname == data.itemFilter) then
                    table.insert(marketData, value);
                end
            end

            SCAAMATFilterTable[data.itemFilter] = marketData;
        end

        -- Gets the max page to prevent the player from passing to a page that potentially doesn't
        -- exist anymore
        maxPages = math.ceil(table.getn(SCAAMATFilterTable[data.itemFilter]) / 10);
        if (maxPages == 0) then
            maxPages = 1;
        end
    else

        -- Gets the max page to prevent the player from passing to a page that potentially doesn't
        -- exist anymore
        maxPages = math.ceil(table.getn(SCAAMATMarketIndex) / 10);
        if (maxPages == 0) then
            maxPages = 1;
        end
    end

    local finalPage = data.page;

    if (finalPage > maxPages) then
        finalPage = maxPages;
    end

    if (data.itemFilter ~= '') then
        for i = (10 * finalPage - 9), (10 * finalPage), 1 do
            if (SCAAMATFilterTable[data.itemFilter][i]) then
                table.insert(formedPageData, {
                    SCAAMATFilterTable[data.itemFilter][i].id; -- item id
                    ISM.GetItemDisplayName(SCAAMATFilterTable[data.itemFilter][i].classname); -- item name
                    SCAAMATFilterTable[data.itemFilter][i].quantity; -- item quantity
                    ISM.GetItemDisplayName(SCAAMATFilterTable[data.itemFilter][i].tradeClassname); -- item trade for name
                    SCAAMATFilterTable[data.itemFilter][i].tradeQuantity; -- item trade for quantity
                    SCAAMATFilterTable[data.itemFilter][i].traderName; -- item trader name
                    SCAAMATFilterTable[data.itemFilter][i].classname; -- item classname
                    -- SCAAMATFilterTable[data.itemFilter][i].tradeClassname; -- item trade classname
                    -- SCAAMATFilterTable[data.itemFilter][i].comment; -- item comment
                    -- SCAAMATFilterTable[data.itemFilter][i].details; -- item details
                });
            end
        end
    else
        for i = (10 * finalPage - 9), (10 * finalPage), 1 do
            if (SCAAMATMarketIndex[i]) then
                table.insert(formedPageData, {
                    SCAAMATMarketIndex[i].id; -- item id
                    ISM.GetItemDisplayName(SCAAMATMarketIndex[i].classname); -- item name
                    SCAAMATMarketIndex[i].quantity; -- item quantity
                    ISM.GetItemDisplayName(SCAAMATMarketIndex[i].tradeClassname); -- item trade for name
                    SCAAMATMarketIndex[i].tradeQuantity; -- item trade for quantity
                    SCAAMATMarketIndex[i].traderName; -- item trader name
                    SCAAMATMarketIndex[i].classname; -- item classname
                    -- SCAAMATMarketIndex[i].tradeClassname; -- item trade classname
                    -- SCAAMATMarketIndex[i].comment; -- item comment
                    -- SCAAMATMarketIndex[i].details; -- item details
                });
            end
        end
    end

    local pageData = {
        currentPage = finalPage,
        maxPage = maxPages;
    };

    -- Sets the page data and the items retrieved on that page
    local fullTradeData = {
        formedPageData,
        pageData
    };

    SCAAMATSendClientData(fullTradeData, 'SetMarketData', playerId);
end

-- SCAAMATGetMarketItemData
-- Gets the requested item data
function SCAAMATGetMarketItemData(data, playerId)
    local itemData = false;
    local startI, endI, stepI = 0, 0, 0;

    -- Decides from where to perform a search:
    -- From index 1 if the item id is closer to to 1
    -- From index on the max item id if it's closer to that number
    -- This to minimize the for calls as much as possible
    if (table.getn(SCAAMATMarketIndex) - data.itemId < data.itemId) then
        startI = 1;
        endI = table.getn(SCAAMATMarketIndex);
        stepI = 1;
    else
        startI = table.getn(SCAAMATMarketIndex);
        endI = 1;
        stepI = -1;
    end

    -- Tries to find the item based on the parameters established before
    for i = startI, endI, stepI do
        local item = SCAAMATMarketIndex[i];

        -- When found, if forms a table containing all the needed info, including the extra
        -- information pertaining to that particular item (fluid or weapon or special data, etc)
        if (item and item.id == data.itemId) then
            itemData = SCAAMATFillItemData(item, true);
            table.insert(itemData, i);
            break;
        end
    end

    -- Sends the formed table data to the client
    SCAAMATSendClientData(itemData, 'SetMarketItemData', playerId);
end

-- SCAAMATAttemptTrade
-- Attempts to finish a trade transaction, checking for availability of the item and quantity
-- And also checking if the player can carry the item or items
function SCAAMATAttemptTrade(data, playerId)

    -- Checks if this id is not in the anti-spam table to continue
    if (SCAAMATCurrentTrades[tostring(data.itemId)]) then

        -- It returns an anti-spam response
        response = {
            'Error',
            "This trade offer is being part of a transaction by another player right now, try again later",
        };
        
        SCAAMATSendClientData(response, 'ShowModal', playerId);
        return;
    end

    -- It adds the id of the attempted trade offer to the table of anti-spam so 2 players won't
    -- perform this transaction if they click it at the same time
    SCAAMATCurrentTrades[tostring(data.itemId)] = true;

    local foundIndex = false;
    local tradeResponse = {};
    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Checks if the item being traded was added by this player to prevent it
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);
    if (terminalData ~= nil) then
        local myPlayerMarket = SCAAMATPlayerMarketTable:GetPage(tostring(terminalData.id));

        if (myPlayerMarket ~= nil) then

            -- Loops through the player market to check for the same trade id
            for key, value in pairs(myPlayerMarket) do
                if (value.id == data.itemId) then
                    tradeResponse = {
                        false,
                        'Error',
                        "You can't trade your own items"
                    };
            
                    -- It returns a trade response to the client depending on what was gathered on this function
                    SCAAMATSendClientData(tradeResponse, 'GetMarketResponse', playerId);

                    SCAAMATCurrentTrades[tostring(data.itemId)] = nil;
                    return;
                end
            end
        end
    end

    -- Performs another item search on the market table, this time using the key as another element to
    -- refine the search and reduce the load as much as possible.
    -- This search is performed because the item could've changed or was removed during the time this player
    -- was in the process of performing the trade transaction
    if (SCAAMATMarketIndex[data.itemIndex] and SCAAMATMarketIndex[data.itemIndex].id == data.itemId) then
        foundIndex = data.itemIndex;
    elseif (SCAAMATMarketIndex[data.itemIndex] and SCAAMATMarketIndex[data.itemIndex].id < data.itemId) then
        for i = data.itemIndex, 1, -1 do
            if (SCAAMATMarketIndex[i].id == data.itemId) then
                foundIndex = i;
                break;
            end
        end
    elseif (SCAAMATMarketIndex[data.itemIndex] and SCAAMATMarketIndex[data.itemIndex].id > data.itemId) then
        for i = data.itemIndex, table.getn(SCAAMATMarketIndex), 1 do
            if (SCAAMATMarketIndex[i].id == data.itemId) then
                foundIndex = i;
                break;
            end
        end
    end

    -- Performs more checks if the item was found
    if (foundIndex ~= false) then
        local marketItemCopy = SCAAMATMarketIndex[foundIndex];

        -- Checks if the quantity available for this item is still greater than the amount the player wants
        -- Again, this because the item might have changed
        if (SCAAMATMarketIndex[foundIndex].quantity >= data.tradeAmount) then
            local ownedItems = 0;
            local hasEnoughItemsForTrade = false;
            local listOfRequestedItems = g_gameRules.game:GetStorageContent(playerId, SCAAMATMarketIndex[foundIndex].tradeClassname);
            local itemsToRemove = {};

            -- Performs a search in the player's inventory to see if it has the items required in this trade
            for key, itemId in pairs(listOfRequestedItems) do
                local item = System.GetEntity(itemId);

                -- It counts the items until it reaches the requested amount
                if (item.item:IsStackable()) then
                    local itemCount = item.item:GetStackCount();
                    if (itemCount > data.tradeAmount * SCAAMATMarketIndex[foundIndex].tradeQuantity) then
                        table.insert(itemsToRemove, {itemId, itemCount - (data.tradeAmount * SCAAMATMarketIndex[foundIndex].tradeQuantity)});
                        ownedItems = ownedItems + data.tradeAmount * SCAAMATMarketIndex[foundIndex].tradeQuantity;
                    else
                        table.insert(itemsToRemove, {itemId, -1});
                        ownedItems = ownedItems + itemCount;
                    end
                else
                    ownedItems = ownedItems + 1;
                    table.insert(itemsToRemove, {itemId, -1});
                end

                if (ownedItems >= data.tradeAmount * SCAAMATMarketIndex[foundIndex].tradeQuantity) then
                    hasEnoughItemsForTrade = true;
                    break;
                end
            end

            -- If the player has enough items then it proceeds to another step of validation.
            -- This time if validates if the player has enough room to hold the items they want for trade
            -- including available slots and weight
            if (hasEnoughItemsForTrade == true) then

                -- Calls the function to perform the inventory check.
                -- This returns the success or failure of this check, if it was successful the function itself
                -- Should have added the desired items so this process is not repeated twice
                local isValid = SCAAMATValidateInventory(SCAAMATMarketIndex[foundIndex], data.tradeAmount, playerId);
                local title = 'Notice';
                local message = 'Trade was completed successfully';
                local quantity = 0;

                -- The inventory validation was successful
                if (isValid == true) then

                    -- It starts removing the requested items for the trade then forms the history text for the
                    -- Trade log of the terminal that was offering this trade, including the items themselves so the
                    -- other player can claim them later
                    for key, value in pairs(itemsToRemove) do
                        local item = System.GetEntity(value[1]);
                        local historyText = 'x' .. data.tradeAmount .. ' ' .. ISM.GetItemDisplayName(SCAAMATMarketIndex[foundIndex].classname) .. ' > x' .. (data.tradeAmount * SCAAMATMarketIndex[foundIndex].tradeQuantity) .. ' ' .. ISM.GetItemDisplayName(SCAAMATMarketIndex[foundIndex].tradeClassname) .. ' | ' .. player:GetName():gsub('%%', '');

                        -- Call to the function to add the items to the terminal storage
                        SCAAMATAddItemToStorage(item, SCAAMATMarketIndex[foundIndex].terminalId, historyText);

                        -- This part removes OR reduces the stack count of an item, this because items with stacks need to be
                        -- considered
                        if (value[2] == -1) then
                            System.RemoveEntity(value[1]);
                        else
                            item.item:SetStackCount(value[2]);
                        end
                    end

                    -- This performs an update to the market table, it removes the item from the market or reduces it's available quantity
                    -- depending on how many items were taken from this transaction
                    if (SCAAMATMarketIndex[foundIndex].quantity - data.tradeAmount <= 0) then
                        isValid = false;

                        -- Adds these changes to the filtered table for this classname in case it exists
                        if (SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname]) then
                            for key, value in pairs(SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname]) do
                                if (value.id == SCAAMATMarketIndex[foundIndex].id) then
                                    table.remove(SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname], key);
                                    
                                    if (table.getn(SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname]) <= 0) then
                                        SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname] = nil;
                                    end
                                    break;
                                end
                            end
                        end

                        table.remove(SCAAMATMarketIndex, foundIndex);
                    else
                        SCAAMATMarketIndex[foundIndex].quantity = SCAAMATMarketIndex[foundIndex].quantity - data.tradeAmount;
                        quantity = SCAAMATMarketIndex[foundIndex].quantity;

                        -- Adds these changes to the filtered table for this classname in case it exists
                        if (SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname]) then
                            for key, value in pairs(SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname]) do
                                if (value.id == SCAAMATMarketIndex[foundIndex].id) then
                                    value.quantity = SCAAMATMarketIndex[foundIndex].quantity;
                                    break;
                                end
                            end
                        end
                    end

                    -- This follows the same update process but this time to the player market table, as these are a copy of the market items
                    -- table but sorted by terminal id for easier search
                    local playerMarket = SCAAMATPlayerMarketTable:GetPage(tostring(marketItemCopy.terminalId));

                    for key, value in pairs(playerMarket) do
                        if (value.id == data.itemId) then
                            if (isValid == true) then
                                value.quantity = marketItemCopy.quantity;
                            else
                                table.remove(playerMarket, key);
                            end
                            
                            break;
                        end
                    end

                    SCAAMATPlayerMarketTable:SetPage(tostring(marketItemCopy.terminalId), playerMarket);
                    SCAAMATMarketTable:SetPage('ServerMarket', SCAAMATMarketIndex);
                else
                    title = 'Error';
                    message = "You don't have enough inventory space or weight capacity to hold this item or items";
                end

                tradeResponse = {
                    isValid,
                    title,
                    message,
                    quantity
                };
            else
                tradeResponse = {
                    true,
                    'Error',
                    "You don't have the items required to perform this trade",
                    SCAAMATMarketIndex[foundIndex].quantity
                };
            end
        else
            tradeResponse = {
                false,
                'Error',
                "This item doesn't have the required amount anymore"
            };
        end
    else
        tradeResponse = {
            false,
            'Error',
            "This item wasn't found, it probably got traded already or was pulled out by the trader or expired"
        };
    end

    -- It returns a trade response to the client depending on what was gathered on this function
    SCAAMATSendClientData(tradeResponse, 'GetMarketResponse', playerId);

    -- It removes this item id from the anti-spam table once the transaction was completed
    -- Regardless of the outcome of it
    SCAAMATCurrentTrades[tostring(data.itemId)] = nil;
end

-- SCAAMATGetMyMarketData
-- Gets the my market items and the storage data for the player requesting this data
function SCAAMATGetMyMarketData(playerId)
    local formedMarketData = {};
    local formedStorageData = {};

    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Checks if the player accessing this terminal has trade data and it's the owner.
    -- Visitor players can't access these menus
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);
    local myPlayerMarket = SCAAMATPlayerMarketTable:GetPage(tostring(terminalData.id));

    if (myPlayerMarket ~= nil) then

        -- Loops through the player market to form the data needed for the UI
        for key, value in pairs(myPlayerMarket) do
            table.insert(formedMarketData, {
                value.id; -- item id
                ISM.GetItemDisplayName(value.classname); -- item name
                value.quantity; -- item quantity
                ISM.GetItemDisplayName(value.tradeClassname); -- item trade for name
                value.tradeQuantity; -- item trade for quantity
                value.traderName; -- item trader name
                value.classname; -- item classname
                -- value.tradeClassname; -- item trade classname
                -- value.comment; -- item comment
                -- value.details; -- item details
            });
        end
    end

    -- Checks if the player accessing this terminal has storage data and it's the owner.
    -- Visitor players can't access these menus
    local storageData = SCAAMATStorageTable:GetPage(tostring(terminalData.id));

    if (storageData ~= nil) then

        -- Loops through the storage to form the data needed for the UI
        for key, value in pairs(storageData) do

            -- Checks if the item looped is a stackable item or not and sets the data in the
            -- table accordingly
            if (value.classname) then
                table.insert(formedStorageData, {
                    -1,
                    value.classname,
                    value.quantity,
                    -1,
                    -1
                });
            else
                for key2, value2 in pairs(value) do
                    local itemHealth = -1;
                    local itemMaxHealth = -1;

                    if (value2.details.health) then
                        itemHealth = value2.details.health;
                        itemMaxHealth = value2.details.maxHealth;
                    end

                    table.insert(formedStorageData, {
                        value2.id,
                        value2.classname,
                        value2.quantity,
                        itemHealth,
                        itemMaxHealth
                    });
                end
            end
        end
    end

    -- Sets the my market and storage data
    local fullMyMarketData = {
        formedMarketData,
        formedStorageData
    };

    SCAAMATSendClientData(fullMyMarketData, 'SetMyMarketData', playerId);
end

-- SCAAMATGetMyMarketItemData
-- Gets the requested item data from the player's market
function SCAAMATGetMyMarketItemData(data, playerId)
    local itemData = false;

    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Gets the terminal id from this player
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);
    local playerMarket = SCAAMATPlayerMarketTable:GetPage(tostring(terminalData.id));

    -- Tries to find the item
    for key, item in pairs(playerMarket) do

        -- When found, if forms a table containing all the needed info, including the extra
        -- information pertaining to that particular item (fluid or weapon or special data, etc)
        if (item.id == data.myItemId) then
            itemData = SCAAMATFillItemData(item, false);
            break;
        end
    end

    -- Sends the formed table data to the client
    SCAAMATSendClientData(itemData, 'SetMyMarketItemData', playerId);
end

-- SCAAMATGetStorageItemData
-- Gets the requested item data from the player's storage
function SCAAMATGetStorageItemData(data, playerId)
    local itemData = false;

    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Gets the terminal id from this player
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);
    local storageData = SCAAMATStorageTable:GetPage(tostring(terminalData.id));
    local item = storageData[data.storageItemName];

    -- Retrieves the storage data based on the stackability of it
    if (data.storageItemId == -1 and item) then
        itemData = {
            -1,
            ISM.GetItemDisplayName(item.classname),
            item.quantity,
            os.date('%Y-%m-%d %H:%M:%S', item.expDate),
            item.classname,
            item.history
        };
    elseif (item) then
        for key, value in pairs(item) do
            if (value.id == data.storageItemId) then
                itemData = {
                    value.id,
                    ISM.GetItemDisplayName(value.classname),
                    value.quantity,
                    os.date('%Y-%m-%d %H:%M:%S', value.expDate),
                    value.classname,
                    value.history
                };
                break;
            end
        end
    else
        response = {
            false,
            'Error',
            "This item wasn't found, it probably expired before you could claim it"
        };

        -- It returns a trade response to the client telling that the item is not available anymore
        SCAAMATSendClientData(response, 'GetStorageResponse', playerId);
        return;
    end

    -- Sends the formed table data to the client
    SCAAMATSendClientData(itemData, 'SetStorageItemData', playerId);
end

-- SCAAMATGetMyOffersData
-- Gets the my market items for the player requesting this data
function SCAAMATGetMyOffersData(playerId)
    local formedMarketData = {};

    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Checks if the player accessing this terminal has trade data and it's the owner.
    -- Visitor players can't access these menus
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);
    local myPlayerMarket = SCAAMATPlayerMarketTable:GetPage(tostring(terminalData.id));

    if (myPlayerMarket ~= nil) then

        -- Loops through the player market to form the data needed for the UI
        for key, value in pairs(myPlayerMarket) do
            table.insert(formedMarketData, {
                value.id; -- item id
                ISM.GetItemDisplayName(value.classname); -- item name
                value.quantity; -- item quantity
                ISM.GetItemDisplayName(value.tradeClassname); -- item trade for name
                value.tradeQuantity; -- item trade for quantity
                value.traderName; -- item trader name
                value.classname; -- item classname
                -- value.tradeClassname; -- item trade classname
                -- value.comment; -- item comment
                -- value.details; -- item details
            });
        end
    end

    SCAAMATSendClientData(formedMarketData, 'SetMyOffersData', playerId);
end

-- SCAAMATGetStorageData
-- Gets the storage data for the player requesting this data
function SCAAMATGetStorageData(playerId)
    local formedStorageData = {};

    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Gets the terminal data
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);

    -- Checks if the player accessing this terminal has storage data and it's the owner.
    -- Visitor players can't access these menus
    local storageData = SCAAMATStorageTable:GetPage(tostring(terminalData.id));

    if (storageData ~= nil) then

        -- Loops through the storage to form the data needed for the UI
        for key, value in pairs(storageData) do

            -- Checks if the item looped is a stackable item or not and sets the data in the
            -- table accordingly
            if (value.classname) then
                table.insert(formedStorageData, {
                    -1,
                    value.classname,
                    value.quantity,
                    -1,
                    -1
                });
            else
                for key2, value2 in pairs(value) do
                    local itemHealth = -1;
                    local itemMaxHealth = -1;

                    if (value2.details.health) then
                        itemHealth = value2.details.health;
                        itemMaxHealth = value2.details.maxHealth;
                    end

                    table.insert(formedStorageData, {
                        value2.id,
                        value2.classname,
                        value2.quantity,
                        itemHealth,
                        itemMaxHealth
                    });
                end
            end
        end
    end

    SCAAMATSendClientData(formedStorageData, 'SetStorageData', playerId);
end

-- SCAAMATAttemptItemRemoval
-- Attempts to remove an item from the trade market, including the player market table
function SCAAMATAttemptItemRemoval(data, playerId)

    -- Checks if this id is not in the anti-spam table to continue
    if (SCAAMATCurrentTrades[tostring(data.myItemId)]) then

        -- It returns an anti-spam response
        response = {
            'Error',
            "This trade offer is being part of a transaction by another player right now, try again later"
        };
        
        SCAAMATSendClientData(response, 'ShowModal', playerId);
        return;
    end

    -- It adds the id of the attempted item removal to the table of anti-spam so 2 players won't
    -- perform this transaction if they click it at the same time
    SCAAMATCurrentTrades[tostring(data.myItemId)] = true;

    local foundIndex = false;
    local removalResponse = {};

    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Checks if the player accessing this terminal has trade data and it's the owner.
    -- Visitor players can't access these menus
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);
    local myPlayerMarket = SCAAMATPlayerMarketTable:GetPage(tostring(terminalData.id));

    local myMarketItemFound = false;
    local marketItemFound = false;

    if (myPlayerMarket ~= nil) then

        -- Loops through the player market to check if the item exists.
        -- It's done through the player market because it's a way smaller table with only
        -- 5 rows max, if the item is found the doing the search in the big market tablet
        -- is worth doing
        for key, value in pairs(myPlayerMarket) do
            if (value.id == data.myItemId) then
                myMarketItemFound = true;
                break;
            end
        end
    end

    -- Performs a search on the market table if the item was found on the player's specific table
    if (myMarketItemFound == true) then
        local startI, endI, stepI = 0, 0, 0;

        -- Decides from where to perform a search:
        -- From index 1 if the item id is closer to to 1
        -- From index on the max item id if it's closer to that number
        -- This to minimize the for calls as much as possible
        if (table.getn(SCAAMATMarketIndex) - data.myItemId < data.myItemId) then
            startI = 1;
            endI = table.getn(SCAAMATMarketIndex);
            stepI = 1;
        else
            startI = table.getn(SCAAMATMarketIndex);
            endI = 1;
            stepI = -1;
        end

        -- Tries to find the item based on the parameters established before
        for i = startI, endI, stepI do
            local item = SCAAMATMarketIndex[i];

            -- When found, if forms a table containing all the needed info, including the extra
            -- information pertaining to that particular item (fluid or weapon or special data, etc)
            if (item and item.id == data.myItemId) then
                marketItemFound = true;
                foundIndex = i;
                break;
            end
        end
    end

    -- If it finds the item in the market table, the script is finally able to perform the removal
    if (myMarketItemFound == true and marketItemFound == true) then

        -- Loops through the player market again to remove the item and move it to storage
        for key, value in pairs(myPlayerMarket) do
            if (value.id == data.myItemId) then
                local removedItem = table.remove(myPlayerMarket, key);
                local historyText = 'x' .. removedItem.quantity .. ' ' .. ISM.GetItemDisplayName(removedItem.classname) .. ' | Removed from market by the owner';

                -- Adds these changes to the filtered table for this classname in case it exists
                if (SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname]) then
                    for key, value in pairs(SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname]) do
                        if (value.id == SCAAMATMarketIndex[foundIndex].id) then
                            table.remove(SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname], key);

                            if (table.getn(SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname]) <= 0) then
                                SCAAMATFilterTable[SCAAMATMarketIndex[foundIndex].classname] = nil;
                            end
                            break;
                        end
                    end
                end
                
                -- Removes the item from the market table
                table.remove(SCAAMATMarketIndex, foundIndex);

                -- Call to the function to add the items to the terminal storage
                SCAAMATAddExpItemToStorage(removedItem, terminalData.id, historyText);

                SCAAMATPlayerMarketTable:SetPage(tostring(terminalData.id), myPlayerMarket);
                SCAAMATMarketTable:SetPage('ServerMarket', SCAAMATMarketIndex);
                break;
            end
        end

        removalResponse = {
            'Notice',
            'Item was removed successfully from the market and added to your storage'
        };
    else
        removalResponse = {
            'Error',
            "This item wasn't found, it probably got traded already or expired"
        };
    end

    -- It returns a trade response to the client depending on what was gathered on this function
    SCAAMATSendClientData(removalResponse, 'GetMyMarketResponse', playerId);

    -- It removes this item id from the anti-spam table once the transaction was completed
    -- Regardless of the outcome of it
    SCAAMATCurrentTrades[tostring(data.myItemId)] = nil;
end

-- SCAAMATAttemptStorageItemClaim
-- Attempts to claim an item at a given quantity from the player's storage
function SCAAMATAttemptStorageItemClaim(data, playerId)
    local claimResponse = {};

    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Gets the terminal data
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);

    -- Checks if the player accessing this terminal has storage data and it's the owner.
    -- Visitor players can't access these menus
    local storageData = SCAAMATStorageTable:GetPage(tostring(terminalData.id));

    if (storageData ~= nil) then

        -- Checks if the item to claim is part of this storage then acts depending
        -- on the item stackability
        if (data.storageItemId == -1 and storageData[data.storageItemName]) then
            if (storageData[data.storageItemName].quantity >= data.claimAmount) then

                -- Calls the function to perform the inventory check.
                -- This returns the success or failure of this check, if it was successful the function itself
                -- Should have added the desired items so this process is not repeated twice
                local isValid = SCAAMATValidateInventory(storageData[data.storageItemName], data.claimAmount, playerId);
                local title = 'Notice';
                local message = 'Claim process was completed successfully';
                local quantity = 0;

                -- The inventory validation was successful
                if (isValid == true) then

                    -- This performs an update to the player storage table, it removes the item from the storage or reduces it's available quantity
                    -- depending on how many items were taken from this transaction
                    if (storageData[data.storageItemName].quantity - data.claimAmount <= 0) then
                        isValid = false;
                        storageData[data.storageItemName] = nil;
                    else
                        storageData[data.storageItemName].quantity = storageData[data.storageItemName].quantity - data.claimAmount;
                        quantity = storageData[data.storageItemName].quantity;
                    end

                    SCAAMATStorageTable:SetPage(tostring(terminalData.id), storageData);
                else
                    title = 'Error';
                    message = "You don't have enough inventory space or weight capacity to hold this item or items";
                end

                claimResponse = {
                    isValid,
                    title,
                    message,
                    quantity
                };
            else
                quantity = storageData[data.storageItemName].quantity;

                claimResponse = {
                    true,
                    'Error',
                    "This stored item doesn't have the desired amount to claim",
                    quantity
                };
            end
        elseif (storageData[data.storageItemName]) then
            local storageIndex = -1;

            -- Tries to find the item in the table because it's unique
            for key, value in pairs(storageData[data.storageItemName]) do
                if (value.id == data.storageItemId) then
                    storageIndex = key;
                    break;
                end
            end

            -- If the item was found it does the claim operation
            if (storageIndex ~= -1) then
                -- Calls the function to perform the inventory check.
                -- This returns the success or failure of this check, if it was successful the function itself
                -- Should have added the desired items so this process is not repeated twice
                local isValid = SCAAMATValidateInventory(storageData[data.storageItemName][storageIndex], 1, playerId);
                local title = 'Notice';
                local message = 'Claim process was completed successfully';

                -- The inventory validation was successful
                if (isValid == true) then

                    -- This performs an update to the player storage table, it removes the item from the storage as it was an unique item
                    isValid = false;
                    table.remove(storageData[data.storageItemName], storageIndex);
                    
                    -- Removes this item if all the rows were removed with this transaction
                    if (table.getn(storageData[data.storageItemName]) <= 0) then
                        storageData[data.storageItemName] = nil;
                    end

                    SCAAMATStorageTable:SetPage(tostring(terminalData.id), storageData);
                else
                    title = 'Error';
                    message = "You don't have enough inventory space or weight capacity to hold this item or items";
                end

                claimResponse = {
                    isValid,
                    title,
                    message
                };
            else
                claimResponse = {
                    false,
                    'Error',
                    "This item wasn't found, it probably expired before you could claim it"
                };
            end
        else
            claimResponse = {
                false,
                'Error',
                "This item wasn't found, it probably expired before you could claim it"
            };
        end
    else
        claimResponse = {
            false,
            'Error',
            "This item wasn't found, it probably expired before you could claim it"
        };
    end

    -- It returns a trade response to the client depending on what was gathered on this function
    SCAAMATSendClientData(claimResponse, 'GetStorageResponse', playerId);
end

-- SCAAMATAttemptAddingItem
-- Attempts to add an item from the player to the market
function SCAAMATAttemptAddingItem(data, playerId, entityIdToRemove)
    local addResponse = {};
    local time = System.GetLocalOSTime();
    local dateTime = 0;
    local curDateTime = 0;

    -- Sets the current date.
    -- Also the current date + 5 days to renew the expiration date
    curDateTime = os.time({year = time.year + 1900, month = time.mon + 1, day = time.mday, hour = time.hour, min = time.min, sec = time.sec});
    dateTime = curDateTime + 5 * 24 * 60 * 60;

    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Gets the terminal data
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);

    -- Gets the player market to check if the player can add more items
    -- since it's limited to 5 per terminal
    local myPlayerMarket = SCAAMATPlayerMarketTable:GetPage(tostring(terminalData.id));

    if (myPlayerMarket == nil or table.getn(myPlayerMarket) < 5) then
        local marketId = SCAAMATParamsTable:GetPage('marketIdCounter');
        local addedItemTable = {};

        -- Removes an item if it's unique, so it does it by entity id,
        -- otherwise removes by stack amount
        if (data.addItemId ~= -1) then
            local item = System.GetEntity(entityIdToRemove);

            -- Adds the item to the market table
            addedItemTable = {
                id = marketId,
                terminalId = terminalData.id,
                classname = data.addItemName,
                quantity = data.addAmount,
                tradeClassname = data.selectedItem,
                tradeQuantity = data.addAmountToTrade,
                traderName = player:GetName():gsub('%%', ''),
                comment = data.addComment,
                expDate = dateTime,
                details = {}
            };

            -- It adds all the individual item properties depending on what the item is.
            -- This includes special modded items that store data in the SQLite database
            if (item.item:GetMaxHealth() > 0) then
                addedItemTable.details.health = item.item:GetHealth();
                addedItemTable.details.maxHealth = item.item:GetMaxHealth();
            end

            if (item.item:IsRefillable()) then
                addedItemTable.details.fluid = item.item:GetConsumableType();
                addedItemTable.details.fluidAmount = item.item:GetConsumablePercent();
            end

            if (item.item:IsMagazine()) then
                addedItemTable.details.magazine = item.item:GetStackCount();
            end

            if (item.weapon) then
                local listOfAttachments = g_gameRules.game:GetStorageContent(item.id, '');

                if (listOfAttachments and table.getn(listOfAttachments) > 0) then
                    addedItemTable.details.attachments = {};

                    for key, itemId in pairs(listOfAttachments) do
                        local attachment = System.GetEntity(itemId);
                        local attachmentData = {
                            classname = attachment.class
                        };

                        if (attachment.item:GetMaxHealth() > 0) then
                            attachmentData.health = attachment.item:GetHealth();
                            attachmentData.maxHealth = attachment.item:GetMaxHealth();
                        end

                        if (attachment.item:IsMagazine()) then
                            attachmentData.stack = attachment.item:GetStackCount();
                        end

                        table.insert(addedItemTable.details.attachments, attachmentData);
                    end
                end
            end

            if (SCAAMATItemSpecialData[item.class]) then
                addedItemTable.details.special = {
                    varName = SCAAMATItemSpecialData[item.class].varName,
                    varValue = item[SCAAMATItemSpecialData[item.class].varName]
                };
            end

            System.RemoveEntity(entityIdToRemove);
        else

            -- Gets the player inventory for the item that is gonna be added to market
            local playerItems = g_gameRules.game:GetStorageContent(playerId, data.addItemName);

            -- Sets the remaining items to remove
            local remainingAmount = data.addAmount;

            -- Loops through the player items to reduce and/or remove the item entities based
            -- on the quantity that's gonna be added
            for key, itemId in pairs(playerItems) do
                local item = System.GetEntity(itemId);

                if (item.item:GetStackCount() - remainingAmount > 0) then
                    item.item:SetStackCount(item.item:GetStackCount() - remainingAmount);
                    break;
                else
                    remainingAmount = remainingAmount - item.item:GetStackCount();
                    System.RemoveEntity(itemId);

                    if (remainingAmount <= 0) then
                        break;
                    end
                end
            end

            -- Adds the item to the market table
            addedItemTable = {
                id = marketId,
                terminalId = terminalData.id,
                classname = data.addItemName,
                quantity = data.addAmount,
                tradeClassname = data.selectedItem,
                tradeQuantity = data.addAmountToTrade,
                traderName = player:GetName():gsub('%%', ''),
                comment = data.addComment,
                expDate = dateTime,
                maxStack = ISM.GetItemStackSize(data.addItemName)
            };
        end

        -- Creates a new table for the player market in case this terminal didn't have
        -- one previously
        if (myPlayerMarket == nil) then
            myPlayerMarket = {};
        end

        table.insert(SCAAMATMarketIndex, 1, addedItemTable);
        table.insert(myPlayerMarket, 1, addedItemTable);

        -- Adds these changes to the filtered table for this classname in case it exists
        if (SCAAMATFilterTable[data.addItemName]) then
            table.insert(SCAAMATFilterTable[data.addItemName], 1, addedItemTable);
        end

        SCAAMATPlayerMarketTable:SetPage(tostring(terminalData.id), myPlayerMarket);
        SCAAMATMarketTable:SetPage('ServerMarket', SCAAMATMarketIndex);
        marketId = marketId + 1;
        SCAAMATParamsTable:SetPage('marketIdCounter', marketId);

        addResponse = {
            false,
            false,
            'Notice',
            "Item or items added to market successfully",
        };
    else
        addResponse = {
            true,
            true,
            'Error',
            "This terminal can't add more items to the market, the limit is 5. You need to remove one of your trade offers first to make some space",
        };
    end

    -- It returns a trade response to the client depending on what was gathered on this function
    SCAAMATSendClientData(addResponse, 'GetAddItemResponse', playerId);
end

-- SCAAMATGetMessagesData
-- Gets the message data for the player requesting this data
function SCAAMATGetMessagesData(playerId)
    local messageData = {};

    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Gets the terminal data
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);

    local terminalMessages = SCAAMATMessagesTable:GetPage(tostring(terminalData.id));

    if (terminalMessages and table.getn(terminalMessages) > 0) then
        for key, message in pairs(terminalMessages) do
            table.insert(messageData, {
                message.id, -- Message id
                message.terminalFromId, -- Terminal id from sender
                message.title, -- Message title
                message.date, -- Message date
                message.fromName, -- Player name from sender
                message.read -- Message read/unread flag
                -- message.content -- The contents of the message
            });
        end
    end

    -- Adds this player to the connected entities to receive 'websockets' updates
    SCAAMATEntitiesConnected[tostring(terminalData.id)] = {
        playerId,
        steamId
    };

    SCAAMATSendClientData(messageData, 'FillMessageData', playerId);
end

-- SCAAMATOpenMessage
-- Gets the message content based on the terminal and message id's
-- Also marks it as read
function SCAAMATOpenMessage(data, playerId)
    local messageContent = '';

    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Gets the terminal data
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);

    local terminalMessages = SCAAMATMessagesTable:GetPage(tostring(terminalData.id));

    -- Tries to find the message by id
    if (terminalMessages and table.getn(terminalMessages) > 0) then
        for key, message in pairs(terminalMessages) do
            if (message.id == data.messageId) then
                messageContent = message.content;
                message.read = 1;
                SCAAMATMessagesTable:SetPage(tostring(terminalData.id), terminalMessages);
                break;
            end
        end
    end

    SCAAMATSendClientData(messageContent, 'SetMessageContent', playerId);
end

-- SCAAMATRemoveMessage
-- Removes a message from this player by message id
function SCAAMATRemoveMessage(data, playerId)
    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    -- Gets the terminal data
    local terminalData = SCAAMATTerminalTable:GetPage(steamId);

    local terminalMessages = SCAAMATMessagesTable:GetPage(tostring(terminalData.id));

    -- Tries to find the message by id
    if (terminalMessages and table.getn(terminalMessages) > 0) then
        for key, message in pairs(terminalMessages) do
            if (message.id == data.messageId) then
                table.remove(terminalMessages, key);
                SCAAMATMessagesTable:SetPage(tostring(terminalData.id), terminalMessages);

                -- It returns the successful response
                response = {
                    'Notice',
                    'Message removed successfully'
                };

                SCAAMATSendClientData(response, 'ShowModal', playerId);
                break;
            end
        end
    end
end

-- SCAAMATAttemptSendMessage
-- Attempts to send a message to another player
function SCAAMATAttemptSendMessage(data, playerId)
    local messageResponse = {};

    -- Gets the max terminal id for validation
    local maxTerminalId = SCAAMATParamsTable:GetPage('terminalIdCounter');

    -- Checks if the terminal id typed is valid
    if (data.terminalId < maxTerminalId) then

        -- Sets the current date.
        local time = System.GetLocalOSTime();
        local curDateTime = os.time({year = time.year + 1900, month = time.mon + 1, day = time.mday, hour = time.hour, min = time.min, sec = time.sec});

        local player = System.GetEntity(playerId);
        local steamId = player.player:GetSteam64Id();

        -- Gets the terminal data
        local terminalData = SCAAMATTerminalTable:GetPage(steamId);
        
        -- If the player has no terminal it generates an undefined string flag
        if (terminalData == nil) then
            terminalData = {
                id = -10
            };
        end

        local destinataryMessages = SCAAMATMessagesTable:GetPage(tostring(data.terminalId));
        local messageId = SCAAMATParamsTable:GetPage('messagesIdCounter');

        -- Checks if the destinatary table exists
        if (not destinataryMessages) then
            destinataryMessages = {}
        end;

        table.insert(destinataryMessages, 1, {
            id = messageId,
            terminalFromId = terminalData.id,
            title = data.messageTitle,
            content = data.messageContent,
            date = os.date('%Y-%m-%d %H:%M:%S', curDateTime),
            fromName = player:GetName():gsub('%%', ''),
            read = 2
        });

        -- Removes the last message in case this terminal has more than 50 messages
        if (table.getn(destinataryMessages) > 50) then
            table.remove(destinataryMessages, 51);
        end

        -- Sends an update to the destinatary player in case it's connected and accessed the
        -- messages app
        if (SCAAMATEntitiesConnected[tostring(data.terminalId)]) then
            local destinataryPlayer = System.GetEntity(SCAAMATEntitiesConnected[tostring(data.terminalId)][1]);

            if (destinataryPlayer and destinataryPlayer.player and destinataryPlayer.player:GetSteam64Id() == SCAAMATEntitiesConnected[tostring(data.terminalId)][2]) then
                local messageData = {
                    messageId, -- Message id
                    terminalData.id, -- Terminal id from sender
                    data.messageTitle, -- Message title
                    os.date('%Y-%m-%d %H:%M:%S', curDateTime), -- Message date
                    player:GetName():gsub('%%', ''), -- Player name from sender
                    2 -- Message read/unread flag
                };
                SCAAMATSendClientData(messageData, 'AddMessageToTerminal', SCAAMATEntitiesConnected[tostring(data.terminalId)][1]);
            else
                SCAAMATEntitiesConnected[tostring(data.terminalId)] = nil;
            end
        end

        messageId = messageId + 1;
        SCAAMATParamsTable:SetPage('messagesIdCounter', messageId);
        SCAAMATMessagesTable:SetPage(tostring(data.terminalId), destinataryMessages);

        messageResponse = {
            true,
            'Notice',
            "Mensaje enviado"
        };
    else
        messageResponse = {
            false,
            'Error',
            "Esa terminal id no existe"
        };
    end

    SCAAMATSendClientData(messageResponse, 'GetMessageResponse', playerId);
end

-- SCAAMATServerUpdateTerminalData
-- Stores the terminal data on misDB
function SCAAMATServerUpdateTerminalData(data, playerId)
    local terminalData = SCAAMATTerminalTable:GetPage(data.steamId);
    local terminalApps = SCAAMATAppsTable:GetPage(data.steamId);

    -- Assings and stores the new data on their respective tables
    terminalData.background = data.data.background;
    terminalApps.applications = data.apps.applications;

    SCAAMATTerminalTable:SetPage(data.steamId, terminalData);
    SCAAMATAppsTable:SetPage(data.steamId, terminalApps);
end

-- SCAAMATGetFloppyDataForTerminal
-- Retrieves the floppy data from this id
function SCAAMATGetFloppyDataForTerminal(playerId, floppyId)
    local item = System.GetEntity(floppyId);
    local labelName = '';
    local labelType = '';

    -- Looks for the readable name and type from this application or game
    for key, value in pairs(SCAAMATApps) do
        if (value[1] == item.SCAAMATAppName) then
            labelName = value[2];
            labelType = 'applications';
            break;
        end
    end

    for key, value in pairs(SCAAMATGames) do
        if (value[1] == item.SCAAMATAppName) then
            labelName = value[2]:sub(1, 1):upper() .. value[2]:sub(2);
            labelType = 'games';
            break;
        end
    end

    local floppyData = {
        item.SCAAMATAppName,
        labelType,
        labelName
    };

    SCAAMATSendClientData(floppyData, 'GetFloppyData', playerId);
end

-- SCAAMATInstallApp
-- Adds the installed application to database
function SCAAMATInstallApp(data, playerId, floppyId)
    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();
    
    -- Gets the terminal app data
    local terminalApps = SCAAMATAppsTable:GetPage(steamId);
    local newAppTable = SCAAMATJSON.parse(data.installData);

    table.insert(terminalApps[data.appType], newAppTable);
    SCAAMATAppsTable:SetPage(steamId, terminalApps);

    -- Removes the floppy entity from the terminal storage
    System.RemoveEntity(floppyId);
end

-- SCAAMATAddStashCoordinate
-- Adds a coordinate to the server list stash
function SCAAMATAddStashCoordinate(data, floppyId, playerId)
    local validCoordinate = nil;

    -- Tries to find a valid position based on a random picked position of the quadrant around it 200m
    while (not validCoordinate) do
        local potentialPos = {x=0, y=0, z=0};
        potentialPos.x = randomF(0, SCAAMATMapScale);
        potentialPos.y = randomF(0, SCAAMATMapScale);
        potentialPos.z = System.GetTerrainElevation(potentialPos);

        -- Checks if there's plotsigns nearby so the player doesn't respawn in a base
        local plotsigns = System.GetEntitiesInSphereByClass(potentialPos, 50, 'PlotSign');

        if (not plotsigns or table.getn(plotsigns) <= 0) then
            local positionToTest = new(potentialPos);

            positionToTest.z = positionToTest.z + 250;

            -- Does a raycast on the position so the player won't respawn in water or some other invalid position (hopefully)
            Physics.RayWorldIntersection(positionToTest, {x = 0, y = 0, z = (-1 * 260)}, 1, ent_all + 0x200, nil, nil, g_HitTable);

            if (g_HitTable[1].dist >= 249.5 and IsInsideTable(SCAAMATValidSurfaces, System.GetSurfaceTypeNameById(g_HitTable[1].surface))) then
                validCoordinate = potentialPos;
            end
        end
    end

    table.insert(SCAAMATStashCoordinates, {
        content = data.stashContent,
        position = validCoordinate
    });

    -- Removes the floppy entity from the terminal storage
    System.RemoveEntity(floppyId);

    -- Sends the valid coordinate to the player to be seen on message
    local coordinateData = {
        validCoordinate
    };

    SCAAMATSendClientData(coordinateData, 'GetCoordinateData', playerId);
end

-- SCAAMATDigPatch
-- Checks the stash coordinates to see if one is close to the player
function SCAAMATDigPatch(itemId, playerId)

    -- Checks if another person is not digging at the same time to prevent duping
    if (SCAAMATIsSomeoneDigging == false) then
        SCAAMATIsSomeoneDigging = true;
        local foundStash = nil;
        local player = System.GetEntity(playerId);

        for key, value in pairs(SCAAMATStashCoordinates) do

            -- If the distance is less or equal than 1.5m then spawn the crate and set the contents
            if (DistanceVectors(value.position, player:GetWorldPos()) <= 1.5) then
                foundStash = value;
                table.remove(SCAAMATStashCoordinates, key);
                break;
            end
        end

        -- If found stash perform the operation to spawn one
        if (foundStash) then

            -- Gets the contents that the crate will have
            local crateContents = SCAAMATGetCrateContents(foundStash.content);

            -- Reduces 5hp from the shovel if it has more hp than 0
            local shovel = System.GetEntity(itemId);

            if (shovel.item:GetHealth() > 0) then
                local shovelHealth = shovel.item:GetHealth() - 5;

                if (shovelHealth < 0) then
                    shovelHealth = 0;
                end

                shovel.item:SetHealth(shovelHealth);

                local stashCrate = ISM.SpawnItem('SCAAMStashCrate', foundStash.position);

                -- Adds the items to the crate entity
                for key2, value2 in pairs(crateContents) do
                    local crateItem = ISM.GiveItem(stashCrate.id, value2);
                    if (crateItem.item:IsStackable() or crateItem.item:IsMagazine()) then
                        crateItem.item:SetStackCount(crateItem.item:GetMaxStackSize());
                    end
                end
            else
                g_gameRules.game:SendTextMessage(0, playerId, "Pala rota ya no se puede usar...");
            end
        else
            g_gameRules.game:SendTextMessage(0, playerId, "No hay nada");
        end

        SCAAMATIsSomeoneDigging = false;
    end
end

-- SCAAMATGetCrateContents
-- Forms a list of contents based on a category
function SCAAMATGetCrateContents(category)
    local generatedCrateTable = {};

    -- Random item amount the crate will have
    local randomChances = {
        HighTierGuns = {min = 10, max = 20},
        NormalGuns = {min = 7, max = 16},
        GeneralSupplies = {min = 8, max = 15},
        BuildingSupplies = {min = 10, max = 15}
    };

    local itemAmount = 0;
    local decidedAmount = math.random(randomChances[category].min, randomChances[category].max);

    -- Loops to fill the table
    while itemAmount <= decidedAmount do

        -- Loops through all the item category types so add them to their respective category
        local spawnedCatItem = SCAAMATSupplyByCategory[category][math.random(table.getn(SCAAMATSupplyByCategory[category]))];

        table.insert(generatedCrateTable, spawnedCatItem.Item);
        itemAmount = itemAmount + 1;

        if (spawnedCatItem.Ammo) then
            table.insert(generatedCrateTable, spawnedCatItem.Ammo[math.random(table.getn(spawnedCatItem.Ammo))]);
            itemAmount = itemAmount + 1;
        end

        if (spawnedCatItem.Attachment1) then
            table.insert(generatedCrateTable, spawnedCatItem.Attachment1[math.random(table.getn(spawnedCatItem.Attachment1))]);
            itemAmount = itemAmount + 1;
        end

        if (spawnedCatItem.Attachment2) then
            table.insert(generatedCrateTable, spawnedCatItem.Attachment2[math.random(table.getn(spawnedCatItem.Attachment2))]);
            itemAmount = itemAmount + 1;
        end
    end

    return generatedCrateTable;
end

-- SCAAMATValidateInventory
-- Validates if the player can carry an item or a bunch of items
function SCAAMATValidateInventory(itemData, tradeAmount, playerId)
    local canStore = false;
    local stackCount = tradeAmount;
    local existingStackCount = 0;
    local listOfItems = g_gameRules.game:GetStorageContent(playerId, itemData.classname);
    local addedItemsTable = {};

    -- If the item does have a stack capacity it starts counting capacities available on the same item
    -- the player may have, so instead of creating new items and using slots, the traded item may be added
    -- to existing stacks
    if (itemData.maxStack) then

        -- Loops through the items
        for key, itemId in pairs(listOfItems) do
            local item = System.GetEntity(itemId);
            stackCount = stackCount - (item.item:GetMaxStackSize() - item.item:GetStackCount());
            existingStackCount = existingStackCount + (item.item:GetMaxStackSize() - item.item:GetStackCount());

            if (stackCount <= 0) then
                canStore = true;
                existingStackCount = tradeAmount;
                break;
            end
        end
    end

    -- If the player had not enough similar items or not enough stack capacity on the found items to hold the
    -- traded items, it starts checking for available slots
    if (canStore == false) then
        local itemsToAdd = 0;

        -- If the item has stack capacity it determines how many slots to check for depending on the current
        -- stack count (if it was reduced by the previous check)
        if (itemData.maxStack) then
            itemsToAdd = math.ceil(stackCount / itemData.maxStack);
        else
            itemsToAdd = tradeAmount;
        end

        -- Performs a loop for every slot needed
        for i = 1, itemsToAdd, 1 do
            local addedItem = ISM.GiveItem(playerId, itemData.classname);

            -- The added item id is included in a table of id's, this table may be used
            -- to remove them in case the slot adding process fails for the next slot loops
            table.insert(addedItemsTable, addedItem.id);

            -- Adds the item to the player's inventory, or not, depending on the slot and weight validation
            if (addedItem.item:GetGUID() ~= '') then

                -- If the item has a stack it starts filling up the items with the remaining stack count
                if (itemData.maxStack) then
                    if (i == itemsToAdd) then
                        addedItem.item:SetStackCount(stackCount % itemData.maxStack);
                    else
                        addedItem.item:SetStackCount(addedItem.item:GetMaxStackSize());
                    end
                end

                -- Adds extra data if the item has details
                if (itemData.details) then

                    -- It starts adding or changing the additional data for this item depending on what
                    -- type of item this is
                    if (itemData.details.health) then
                        addedItem.item:SetHealth(itemData.details.health);
                    end

                    if (itemData.details.fluid) then
                        addedItem.item:SetConsumableType(itemData.details.fluid);
                        addedItem.item:SetConsumablePercent(itemData.details.fluidAmount);
                    end

                    if (itemData.details.attachments) then
                        for key, value in pairs(itemData.details.attachments) do
                            local accessory = ISM.GiveItem(addedItem.id, value.classname, false, addedItem.id);
                            
                            if (value.health) then
                                accessory.item:SetHealth(value.health);
                            end
                            
                            if (value.stack) then
                                accessory.item:SetStackCount(value.stack);
                            end
                        end
                    end

                    if (itemData.details.magazine) then
                        addedItem.item:SetStackCount(itemData.details.magazine);
                    end

                    if (itemData.details.special) then
                        addedItem[itemData.details.special.varName] = itemData.details.special.varValue;
                    end
                end
            else

                -- It got to this part because the player couldn't hold the new items so it removes the added items
                -- so far, it's basically a rollback of the performed operation before this point
                for key, value in pairs(addedItemsTable) do
                    System.RemoveEntity(value);
                end

                addedItemsTable = {};
                break;
            end
        end

        -- Performs a last check to see if the amount of added items is the same as the items set to be added, meaning that
        -- the validation and the addition of the items was successful
        if (table.getn(addedItemsTable) == itemsToAdd) then
            canStore = true;
        end
    end

    -- This final part adds stack to the already existing items.
    -- The stack is coming from the stack amount removed from the initial check
    if (canStore == true and itemData.maxStack and existingStackCount > 0) then

        -- Loops through the items
        for key, itemId in pairs(listOfItems) do
            local item = System.GetEntity(itemId);
            local itemAvailableStack = item.item:GetMaxStackSize() - item.item:GetStackCount();

            if (itemAvailableStack - existingStackCount >= 0) then
                item.item:SetStackCount(item.item:GetStackCount() + existingStackCount);
                break;
            else
                item.item:SetStackCount(item.item:GetMaxStackSize());
                existingStackCount = existingStackCount - itemAvailableStack;
            end
        end
    end

    -- Returns the validation result
    return canStore;
end

-- SCAAMATAddItemToStorage
-- Adds an item to a terminal's storage
function SCAAMATAddItemToStorage(item, terminalId, historyText)
    local storageTable = SCAAMATStorageTable:GetPage(tostring(terminalId));
    if (not storageTable) then
        storageTable = {};
    end
    local time = System.GetLocalOSTime();
    local dateTime = 0;
    local curDateTime = 0;

    -- Sets the current date.
    -- Also the current date + 4 days to renew the expiration date
    curDateTime = os.time({year = time.year + 1900, month = time.mon + 1, day = time.mday, hour = time.hour, min = time.min, sec = time.sec});
    dateTime = curDateTime + 4 * 24 * 60 * 60;

    -- If the item is stackable, not a magazine and there was the same item in storage, it basically
    -- adds stack to the existing item, also the history log and extends the expiration time.
    -- If the item meets the previous conditions but it wasn't in storage it adds a new registry of the item
    -- in the storage
    -- If the item is not stackable it simply adds the item in an existing registry of the item or a new one
    -- but this time as part of a new table for the same item, and each row containing the individual data
    -- for this trade, as each non-stackable item is unique in it's properties
    if (storageTable[item.class] and item.item:IsStackable() and not item.item:IsMagazine()) then
        storageTable[item.class].quantity = storageTable[item.class].quantity + item.item:GetStackCount();
        storageTable[item.class].expDate = dateTime;
        storageTable[item.class].history = historyText .. ' | ' .. os.date('%Y-%m-%d %H:%M:%S', curDateTime) .. '\n' .. storageTable[item.class].history;
    elseif (not storageTable[item.class] and item.item:IsStackable() and not item.item:IsMagazine()) then
        storageTable[item.class] = {
            classname = item.class,
            quantity = item.item:GetStackCount(),
            maxStack = item.item:GetMaxStackSize(),
            health = -1,
            maxHealth = -1,
            expDate = dateTime,
            history = historyText .. ' | ' .. os.date('%Y-%m-%d %H:%M:%S', curDateTime)
        };
    else

        -- It creates the item table for this item in specific
        if (not storageTable[item.class]) then
            storageTable[item.class] = {};
        end

        local itemTable = {
            id = math.random(999999);
            classname = item.class,
            quantity = 1,
            expDate = dateTime,
            history = historyText .. ' | ' .. os.date('%Y-%m-%d %H:%M:%S', curDateTime),
            details = {}
        };

        -- It adds all the individual item properties depending on what the item is.
        -- This includes special modded items that store data in the SQLite database
        if (item.item:GetMaxHealth() > 0) then
            itemTable.details.health = item.item:GetHealth();
            itemTable.details.maxHealth = item.item:GetMaxHealth();
        end

        if (item.item:IsRefillable()) then
            itemTable.details.fluid = item.item:GetConsumableType();
            itemTable.details.fluidAmount = item.item:GetConsumablePercent();
        end

        if (item.item:IsMagazine()) then
            itemTable.details.magazine = item.item:GetStackCount();
        end

        if (item.weapon) then
            local listOfAttachments = g_gameRules.game:GetStorageContent(item.id, '');

            if (listOfAttachments and table.getn(listOfAttachments) > 0) then
                itemTable.details.attachments = {};

                for key, itemId in pairs(listOfAttachments) do
                    local attachment = System.GetEntity(itemId);
                    local attachmentData = {
                        classname = attachment.class
                    };

                    if (attachment.item:GetMaxHealth() > 0) then
                        attachmentData.health = attachment.item:GetHealth();
                        attachmentData.maxHealth = attachment.item:GetMaxHealth();
                    end

                    if (attachment.item:IsMagazine()) then
                        attachmentData.stack = attachment.item:GetStackCount();
                    end

                    table.insert(itemTable.details.attachments, attachmentData);
                end
            end
        end

        if (SCAAMATItemSpecialData[item.class]) then
            itemTable.details.special = {
                varName = SCAAMATItemSpecialData[item.class].varName,
                varValue = item[SCAAMATItemSpecialData[item.class].varName]
            };
        end

        table.insert(storageTable[item.class], itemTable);
    end

    SCAAMATStorageTable:SetPage(tostring(terminalId), storageTable);
end

-- SCAAMATAddExpItemToStorage
-- Adds an expired or remove item to a terminal's storage
function SCAAMATAddExpItemToStorage(item, terminalId, historyText)
    local storageTable = SCAAMATStorageTable:GetPage(tostring(terminalId));
    if (not storageTable) then
        storageTable = {};
    end
    local time = System.GetLocalOSTime();
    local dateTime = 0;
    local curDateTime = 0;

    -- Sets the current date.
    -- Also the current date + 4 days to renew the expiration date
    curDateTime = os.time({year = time.year + 1900, month = time.mon + 1, day = time.mday, hour = time.hour, min = time.min, sec = time.sec});
    dateTime = curDateTime + 4 * 24 * 60 * 60;

    -- It adds the item to storage based on the information coming from the market table
    if (storageTable[item.classname] and item.maxStack) then
        storageTable[item.classname].quantity = storageTable[item.classname].quantity + item.quantity;
        storageTable[item.classname].expDate = dateTime;
        storageTable[item.classname].history = historyText .. ' | ' .. os.date('%Y-%m-%d %H:%M:%S', curDateTime) .. '\n' .. storageTable[item.classname].history;
    elseif (not storageTable[item.classname] and item.maxStack) then
        storageTable[item.classname] = {
            classname = item.classname,
            quantity = item.quantity,
            maxStack = item.maxStack,
            health = -1,
            maxHealth = -1,
            expDate = dateTime,
            history = historyText .. ' | ' .. os.date('%Y-%m-%d %H:%M:%S', curDateTime)
        };
    else

        -- It creates the item table for this item in specific
        if (not storageTable[item.classname]) then
            storageTable[item.classname] = {};
        end

        local itemTable = {
            id = math.random(999999);
            classname = item.classname,
            quantity = 1,
            expDate = dateTime,
            history = historyText .. ' | ' .. os.date('%Y-%m-%d %H:%M:%S', curDateTime),
            details = {}
        };

        -- It adds all the individual item properties depending on what the item is.
        -- This includes special modded items that store daa in the SQLite database
        if (item.details.health) then
            itemTable.details.health = item.details.health;
            itemTable.details.maxHealth = item.details.maxHealth;
        end

        if (item.details.fluid) then
            itemTable.details.fluid = item.details.fluid;
            itemTable.details.fluidAmount = item.details.fluidAmount;
        end

        if (item.details.magazine) then
            itemTable.details.magazine = item.details.magazine;
        end

        if (item.details.attachments) then
            itemTable.details.attachments = {};

            for key, value in pairs(item.details.attachments) do
                local attachment = System.GetEntity(itemId);
                local attachmentData = {
                    classname = value.classname
                };

                if (value.health) then
                    attachmentData.health = value.health;
                    attachmentData.maxHealth = value.maxHealth;
                end

                if (value.stack) then
                    attachmentData.stack = value.stack;
                end

                table.insert(itemTable.details.attachments, attachmentData);
            end
        end

        if (item.details.special) then
            itemTable.details.special = {
                varName = item.details.special.varName,
                varValue = item.details.special.varValue
            };
        end

        table.insert(storageTable[item.classname], itemTable);
    end

    SCAAMATStorageTable:SetPage(tostring(terminalId), storageTable);
end

-- SCAAMATFillItemData
-- Fills the item data in a table readable for the trade UI
function SCAAMATFillItemData(item, includeTraderName)
    local itemData = {
        item.id,
        ISM.GetItemDisplayName(item.classname),
        item.quantity,
        ISM.GetItemDisplayName(item.tradeClassname),
        item.tradeQuantity,
        item.classname,
        item.tradeClassname,
        item.comment
    };

    if (includeTraderName == true) then
        table.insert(itemData, 6, item.traderName);
    end

    -- Add item details if it has them
    if (item.details) then
        local extraData = '';

        if (item.details.health) then
            extraData = extraData .. 'Health: ' .. item.details.health .. '/' .. item.details.maxHealth .. '\n';
        end

        if (item.details.fluid) then
            if (item.details.fluid == 0) then
                extraData = extraData .. 'Fluid: Smells like diesel, ' .. item.details.fluidAmount .. '%\n';
            elseif (item.details.fluid == 1) then
                extraData = extraData .. 'Fluid: Smells like propane, ' .. item.details.fluidAmount .. '%\n';
            elseif (item.details.fluid == 2) then
                extraData = extraData .. 'Fluid: Seems fine, ' .. item.details.fluidAmount .. '%\n';
            elseif (item.details.fluid == 3) then
                extraData = extraData .. 'Fluid: Seems old and dirty, ' .. item.details.fluidAmount .. '%\n';
            elseif (item.details.fluid == 4) then
                extraData = extraData .. 'Fluid: Smells strange, ' .. item.details.fluidAmount .. '%\n';
            elseif (item.details.fluid == 5) then
                extraData = extraData .. 'Fluid: Seems fine, ' .. item.details.fluidAmount .. '%\n';
            elseif (item.details.fluid == 6) then
                extraData = extraData .. 'Fluid: Smells strange, ' .. item.details.fluidAmount .. '%\n';
            else
                extraData = extraData .. 'Fluid: Smells like alcohol, ' .. item.details.fluidAmount .. '%\n';
            end
        end

        if (item.details.attachments) then
            extraData = extraData .. 'Attachments:\n';

            for key, value in pairs(item.details.attachments) do
                extraData = extraData .. ISM.GetItemDisplayName(value.classname);

                if (value.health) then
                    extraData = extraData .. ', Health: ' .. value.health .. '/' .. value.maxHealth;
                end

                if (value.stack) then
                    extraData = extraData .. ', Ammo: x' .. value.stack;
                end

                extraData = extraData .. '\n';
            end
        end

        if (item.details.magazine) then
            extraData = extraData .. 'Ammo: x' .. item.details.magazine .. '\n';
        end

        if (item.details.special) then
            extraData = extraData .. 'Special Info: ' .. SCAAMATItemSpecialData[item.classname].description;

            if (item.classname == 'SCAAMGameFloppyDisk' or item.classname == 'SCAAMAppFloppyDisk') then
                local labelName = '';

                -- Looks for the readable name from this application or game
                for key, value in pairs(SCAAMATApps) do
                    if (value[1] == item.details.special.varValue) then
                        labelName = value[2];
                        break;
                    end
                end

                for key, value in pairs(SCAAMATGames) do
                    if (value[1] == item.details.special.varValue) then
                        labelName = value[2]:sub(1, 1):upper() .. value[2]:sub(2);
                        break;
                    end
                end

                extraData = extraData .. labelName;
            elseif (SCAAMATItemSpecialData[item.classname].includeValue == true) then
                extraData = extraData .. item.details.special.varValue;
            end
        end

        table.insert(itemData, extraData);
    else
        table.insert(itemData, '');
    end

    return itemData;
end

-- SCAAMATFillInventoryTable
-- Forms a table for the UI containing the player's inventory contents
-- it mergers stackable items into 1 single element for the UI
function SCAAMATFillInventoryTable(itemIds, itemData, level)

    -- Loops through the player inventory id's
    for key, itemId in pairs(itemIds) do
        local item = System.GetEntity(itemId);

        -- Checks if the item is not the invisible NoWeapon item
        if (item.item:GetDisplayName() ~= 'NoWeapon') then

            -- Adds the item to the table depending on stackability and other factors
            if (item.item:IsStackable() and not item.item:IsMagazine()) then
                local itemIndex = -1;

                -- If the stackable item was already added to the table it uses that row
                -- to add the stack to it, or creates a new row
                for key2, value in pairs(itemData) do
                    if (value[2] == item.class) then
                        itemIndex = key2;
                        break;
                    end
                end

                if (itemIndex ~= -1) then
                    itemData[itemIndex][3] = itemData[itemIndex][3] + item.item:GetStackCount();
                else
                    table.insert(itemData, {
                        -1,
                        item.class,
                        item.item:GetStackCount(),
                        -1,
                        -1,
                        item.item:GetDisplayName()
                    });
                end
            else
                -- If the item is a weapon or magazine it adds it directly, if that's not the case
                -- it checks if it's an storage (backpack, shirt, etc) to ignore this addition
                -- but instead to add the items being contained, having in mind stackability and such
                -- This only if this is the first level of items found
                if (item.weapon) then
                    table.insert(itemData, {
                        item:GetRawId(),
                        item.class,
                        1,
                        item.item:GetHealth(),
                        item.item:GetMaxHealth(),
                        item.item:GetDisplayName()
                    });
                elseif (item.item:IsMagazine()) then
                    table.insert(itemData, {
                        item:GetRawId(),
                        item.class,
                        item.item:GetStackCount(),
                        -1,
                        -1,
                        item.item:GetDisplayName()
                    });
                else

                    -- Finds the items contained on this potential 1st level container
                    local subItems = g_gameRules.game:GetStorageContent(item.id, '');

                    if (subItems and table.getn(subItems) > 0 and level == 1) then

                        -- Recalls the function to add the items from this storage to the table
                        SCAAMATFillInventoryTable(subItems, itemData, level + 1);
                    else

                        -- Adds the regular item checking for the health levels
                        local itemTable = {
                            item:GetRawId(),
                            item.class,
                            1,
                            -1,
                            -1,
                            item.item:GetDisplayName()
                        };
                        
                        if (item.item:GetMaxHealth() > 0) then
                            itemTable[4] = item.item:GetHealth();
                            itemTable[5] = item.item:GetMaxHealth();
                        end

                        table.insert(itemData, itemTable);
                    end
                end
            end
        end
    end
end

-- SCAAMATGetLongData
-- Gets a portion of long information to perform an operation on server
function SCAAMATGetLongData(playerId, operation, chunkOne, chunkTwo, chunkThree, chunkFour)
    local data = SCAAMATJSON.parse(chunkOne .. chunkTwo .. chunkThree .. chunkFour);
    SCAAMATUIFunctions[operation](SCAAMATUIFunctions, data, playerId);
end

---------------------------------------------------------------------------------------
----------------------------- SMART UI TABLE FUNCTIONS --------------------------------
---------------------------------------------------------------------------------------

-- SCAAMATUIFunctions:InitPlayer
-- Initializes the player sending the server's extra data
function SCAAMATUIFunctions:InitPlayer(data)
    if (SCAAMATJSON == nil) then
        SCAAMATJSON = require('JSON');
    end

    local JSONData = SCAAMATJSON.parse(data);

    -- Sets the map data
    SCAAMATMapName = System.GetCVar('sv_map');
    SCAAMATMapScale = 0;

    if (System.IsValidMapPos({x = 8692, y = 8692, z = 100}) == true) then
        SCAAMATMapScale = 8192;
    elseif (System.IsValidMapPos({x = 4596, y = 4596, z = 100}) == true) then
        SCAAMATMapScale = 4096;
    elseif (System.IsValidMapPos({x = 2548, y = 2548, z = 100}) == true) then
        SCAAMATMapScale = 2048;
    elseif (System.IsValidMapPos({x = 1524, y = 1524, z = 100}) == true) then
        SCAAMATMapScale = 1024;
    elseif (System.IsValidMapPos({x = 1012, y = 1012, z = 100}) == true) then
        SCAAMATMapScale = 512;
    elseif (System.IsValidMapPos({x = 756, y = 756, z = 100}) == true) then
        SCAAMATMapScale = 256;
    elseif (System.IsValidMapPos({x = 628, y = 628, z = 100}) == true) then
        SCAAMATMapScale = 128;
    end

    if (SCAAMATMapName == 'canyonlands') then
        SCAAMATMapScale = 5537;
    end

    -- Pending, add support for custom data
    entities = System.GetEntitiesByClass('SCAAMAmalgamatedTerminalManager');

    if (entities and table.getn(entities) > 0) then
        for key, value in pairs(entities) do
            SCAAMATLocalManager = value;
            break;
        end
    end

    SCAAMATInitItemData();
end

-- SCAAMATUIFunctions:AccessTerminal
-- Opens the terminal UI with a set of instructions from this terminal in specific
function SCAAMATUIFunctions:AccessTerminal(data)
    if (SCAAMATJSON == nil) then
        SCAAMATJSON = require('JSON');
    end

    local terminalData = SCAAMATJSON.parse(data);
    local terminalId = terminalData.data.id;

    -- It opens the terminal UI from a previous state or reloaded depending on whether
    -- the player was using this terminal previously and recently
    if (SCAAMATTerminalId == 0 or SCAAMATTerminalId == terminalId) then
        self:ToggleTerminalUI('on');
        if (SCAAMATTerminalData ~= nil and SCAAMATTableEquals(terminalData, SCAAMATTerminalData, false) == false) then
            Script.SetTimerForFunction(50, 'SCAAMATUpdateTerminalAfterDelay', terminalData);
        else
            Script.SetTimerForFunction(50, 'SCAAMATInitializeTerminalAfterDelay', terminalData);
        end
    else
        self:ToggleTerminalUI('reload');
        if (SCAAMATTerminalData ~= nil and SCAAMATTableEquals(terminalData, SCAAMATTerminalData, false) == false) then
            Script.SetTimerForFunction(50, 'SCAAMATUpdateTerminalAfterDelay', terminalData);
        else
            Script.SetTimerForFunction(50, 'SCAAMATInitializeTerminalAfterDelay', terminalData);
        end
    end

    SCAAMATTerminalData = terminalData;
    SCAAMATTerminalId = terminalId;
    SCAAMATTerminalSteamId = terminalData.steamId;
end

-- SCAAMATInitializeTerminalAfterDelay
-- Initializes the terminal with data after a delay
function SCAAMATInitializeTerminalAfterDelay(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'InitializeTerminal', SCAAMATJSON.stringify(data));
end

-- SCAAMATUpdateTerminalAfterDelay
-- Updates the terminal state and data after a delay
function SCAAMATUpdateTerminalAfterDelay(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'UpdateTerminal', SCAAMATJSON.stringify(data));
end

-- SCAAMATUIFunctions:CloseUI
-- Opens the terminal UI with a set of instructions from this terminal in specific
function SCAAMATUIFunctions:CloseUI(data)
    self:ToggleTerminalUI('unload');
end

-- SCAAMATUIFunctions:ToggleTerminalUI
-- Toggles the terminal UI
function SCAAMATUIFunctions:ToggleTerminalUI(toggle)
    if (toggle == 'on') then
        UIAction.ShowElement('mod_SCAAMAmalgamatedTerminalUI', 0);
        if (UIAction.GetVariable('mod_SCAAMAmalgamatedTerminalUI', 0, 'CurrentFrame') == 1) then
            UIAction.GotoAndStop('mod_SCAAMAmalgamatedTerminalUI', 0, '_root', 2);
            UIAction.SetVariable('mod_SCAAMAmalgamatedTerminalUI', 0, 'CurrentFrame', 2);
        end

        if (SCAAMATSelectedCamera) then
            CryAction.ResetToNormalCamera();
            CryAction.SetViewCamera(SCAAMATSelectedCameraPosDir[1], SCAAMATSelectedCameraPosDir[2]);
            CryAction.SetViewCamera(SCAAMATSelectedCameraPosDir[1], SCAAMATSelectedCameraPosDir[2]);
            UIAction.SetVisible('UsableMenu', -1, '_root', false);
        end
    elseif (toggle == 'off') then
        UIAction.HideElement('mod_SCAAMAmalgamatedTerminalUI', 0);

        if (SCAAMATSelectedCamera) then
            CryAction.ResetToNormalCamera();
            UIAction.SetVisible('UsableMenu', -1, '_root', true);
        end

        SCAAMATCheckForTerminalChanges();
    elseif (toggle == 'reload') then
        UIAction.GotoAndStop('mod_SCAAMAmalgamatedTerminalUI', 0, '_root', 2);
        UIAction.SetVariable('mod_SCAAMAmalgamatedTerminalUI', 0, 'CurrentFrame', 2);
        UIAction.ShowElement('mod_SCAAMAmalgamatedTerminalUI', 0);
    else
        if (SCAAMATSelectedCamera) then
            CryAction.ResetToNormalCamera();
            SCAAMATSelectedCamera = nil;
            SCAAMATSelectedCameraPosDir = nil;
            UIAction.SetVisible('UsableMenu', -1, '_root', true);
        end

        -- Cleans the terminal data
        SCAAMATTerminalData = nil;
        UIAction.GotoAndStop('mod_SCAAMAmalgamatedTerminalUI', 0, '_root', 1);
        UIAction.SetVariable('mod_SCAAMAmalgamatedTerminalUI', 0, 'CurrentFrame', 1);
        UIAction.HideElement('mod_SCAAMAmalgamatedTerminalUI', 0);

        SCAAMATCheckForTerminalChanges();
    end

    if (toggle == 'on' or toggle == 'reload') then
        ActionMapManager.EnableActionFilter('no_mouse', true);
        ActionMapManager.EnableActionFilter('no_mouseX', true);
        ActionMapManager.EnableActionFilter('no_mouseY', true);
        ActionMapManager.EnableActionFilter('no_move', true);
        ActionMapManager.EnableActionFilter('inventory', true);
        ActionMapManager.EnableActionFilter('ladder_only', true);
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'DisplayMessage', 'DisplayMessage');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'CloseTerminal', 'CloseTerminal');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetMarketData', 'GetMarketData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetMarketItemData', 'GetMarketItemData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'AttemptTrade', 'AttemptTrade');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetMyMarketData', 'GetMyMarketData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetMyMarketItemData', 'GetMyMarketItemData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetStorageItemData', 'GetStorageItemData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetMyOffersData', 'GetMyOffersData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetStorageData', 'GetStorageData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'AttemptItemRemoval', 'AttemptItemRemoval');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'AttemptStorageItemClaim', 'AttemptStorageItemClaim');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetItemData', 'GetItemData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'AttemptAddingItem', 'AttemptAddingItem');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetMessagesData', 'GetMessagesData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'OpenMessage', 'OpenMessage');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'RemoveMessage', 'RemoveMessage');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'AttemptSendMessage', 'AttemptSendMessage');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'ReadDisk', 'ReadDisk');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'InstallApp', 'InstallApp');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetCamerasData', 'GetCamerasData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'ChangeCamera', 'ChangeCamera');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'StopCameras', 'StopCameras');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'ChangeCameraDirection', 'ChangeCameraDirection');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'ReadConsoleDisk', 'ReadConsoleDisk');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'GetEncryptedDiskData', 'GetEncryptedDiskData');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'SelectPermission', 'SelectPermission');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'ChangeBackground', 'ChangeBackground');
        UIAction.RegisterElementListener(self, 'mod_SCAAMAmalgamatedTerminalUI', 0, 'MoveApplications', 'MoveApplications');
    else
        ActionMapManager.EnableActionFilter('no_mouse', false);
        ActionMapManager.EnableActionFilter('no_mouseX', false);
        ActionMapManager.EnableActionFilter('no_mouseY', false);
        ActionMapManager.EnableActionFilter('no_move', false);
        ActionMapManager.EnableActionFilter('inventory', false);
        ActionMapManager.EnableActionFilter('ladder_only', false);
        UIAction.UnregisterElementListener(self, 'DisplayMessage');
        UIAction.UnregisterElementListener(self, 'CloseTerminal');
        UIAction.UnregisterElementListener(self, 'GetMarketData');
        UIAction.UnregisterElementListener(self, 'GetMarketItemData');
        UIAction.UnregisterElementListener(self, 'AttemptTrade');
        UIAction.UnregisterElementListener(self, 'GetMyMarketData');
        UIAction.UnregisterElementListener(self, 'GetMyMarketItemData');
        UIAction.UnregisterElementListener(self, 'GetStorageItemData');
        UIAction.UnregisterElementListener(self, 'GetMyOffersData');
        UIAction.UnregisterElementListener(self, 'GetStorageData');
        UIAction.UnregisterElementListener(self, 'AttemptItemRemoval');
        UIAction.UnregisterElementListener(self, 'AttemptStorageItemClaim');
        UIAction.UnregisterElementListener(self, 'GetItemData');
        UIAction.UnregisterElementListener(self, 'AttemptAddingItem');
        UIAction.UnregisterElementListener(self, 'GetMessagesData');
        UIAction.UnregisterElementListener(self, 'OpenMessage');
        UIAction.UnregisterElementListener(self, 'RemoveMessage');
        UIAction.UnregisterElementListener(self, 'AttemptSendMessage');
        UIAction.UnregisterElementListener(self, 'ReadDisk');
        UIAction.UnregisterElementListener(self, 'InstallApp');
        UIAction.UnregisterElementListener(self, 'GetCamerasData');
        UIAction.UnregisterElementListener(self, 'ChangeCamera');
        UIAction.UnregisterElementListener(self, 'StopCameras');
        UIAction.UnregisterElementListener(self, 'ChangeCameraDirection');
        UIAction.UnregisterElementListener(self, 'ReadConsoleDisk');
        UIAction.UnregisterElementListener(self, 'GetEncryptedDiskData');
        UIAction.UnregisterElementListener(self, 'SelectPermission');
        UIAction.UnregisterElementListener(self, 'ChangeBackground');
        UIAction.UnregisterElementListener(self, 'MoveApplications');

        mSendEvent(
            'Server',
            {
                Type = 'SCAAMATFreeTerminal',
                Data = {
                    terminalId = SCAAMATTerminalId,
                    steamId = SCAAMATTerminalSteamId
                }
            },
            false,
            false
        );
    end
end

-- SCAAMATCheckForTerminalChanges
-- Checks for any terminal changes this device may have
function SCAAMATCheckForTerminalChanges()

    -- Checks if the terminal had changes to apply them on server
    if (SCAAMATTerminalChanged == true) then

        -- Sends the JSON string in small chunks
        local JSONText = SCAAMATJSON.stringify(SCAAMATTerminalData);
        local JSONLength = string.len(JSONText);
        local textChunk = math.ceil(JSONLength / 1000);
        local chunkData = {};

        for i = 1, textChunk, 1 do
            if (i == 1) then
                table.insert(chunkData, string.sub(JSONText, 1, 1000));
            else
                table.insert(chunkData, string.sub(JSONText, ((i - 1) * 1000 + 1), (i * 1000)));
            end
        end

        local chunksToRemove = 4;
        local chunksToGrab = {};

        while (chunksToRemove > 0) do

            -- Checks if the table has chunks
            if (table.getn(chunkData) > 0) then
                table.insert(chunksToGrab, table.remove(chunkData, 1));
            else
                table.insert(chunksToGrab, '');
            end

            chunksToRemove = chunksToRemove - 1;
        end

        SCAAMATLocalManager.server:SendLongData(g_localActorId, 'ServerUpdateTerminalData', chunksToGrab[1], chunksToGrab[2], chunksToGrab[3], chunksToGrab[4]);
        SCAAMATTerminalChanged = false;
    end
end

-- SCAAMATUIFunctions:DisplayMessage
-- Logs a message from the UI
function SCAAMATUIFunctions:DisplayMessage(elementName, instanceId, eventName, argTable)
    Log(argTable[0]);
end

-- SCAAMATUIFunctions:CloseTerminal
-- Closes the terminal UI
function SCAAMATUIFunctions:CloseTerminal(elementName, instanceId, eventName, argTable)
    SCAAMATUIFunctions:ToggleTerminalUI('off')
end

-- SCAAMATUIFunctions:ShowModal
-- Sets the storage item data
function SCAAMATUIFunctions:ShowModal(data)
    local modalData = SCAAMATJSON.parse(data);
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'showModal', modalData[1], modalData[2]);
end

-- SCAAMATUIFunctions:GetMarketData
-- Requests the market data in a determined page
function SCAAMATUIFunctions:GetMarketData(elementName, instanceId, eventName, argTable)
    if (argTable[0] ~= 'undefined' and argTable[1] ~= 'undefined') then
        mSendEvent(
            'Server',
            {
                Type = 'SCAAMATGetMarketData',
                Data = {
                    page = argTable[0],
                    itemFilter = argTable[1]
                }
            },
            false,
            false
        );
    end
end

-- SCAAMATUIFunctions:SetMarketData
-- Sets the market data in the UI on a determined page
function SCAAMATUIFunctions:SetMarketData(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'FillTradeData', data);
end

-- SCAAMATUIFunctions:GetMarketItemData
-- Requests the market item data
function SCAAMATUIFunctions:GetMarketItemData(elementName, instanceId, eventName, argTable)
    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATGetMarketItemData',
            Data = {
                itemId = argTable[0]
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:SetMarketItemData
-- Sets the market item data
function SCAAMATUIFunctions:SetMarketItemData(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetMarketItemData', data);
end

-- SCAAMATUIFunctions:AttemptTrade
-- Performs an attempt to finish a trade transaction
function SCAAMATUIFunctions:AttemptTrade(elementName, instanceId, eventName, argTable)
    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATAttemptTrade',
            Data = {
                itemId = argTable[0],
                itemIndex = argTable[1],
                tradeAmount = argTable[2]
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:GetMarketResponse
-- Sets and prints a response to an attempted trade
function SCAAMATUIFunctions:GetMarketResponse(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetMarketResponse', data);
end

-- SCAAMATUIFunctions:GetMyMarketData
-- Requests the my market data to get the player current trade offers and the storage data
function SCAAMATUIFunctions:GetMyMarketData(elementName, instanceId, eventName, argTable)
    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATGetMyMarketData',
            Data = {
                dummyData = ''
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:SetMyMarketData
-- Sets the player market and the storage data in the UI
function SCAAMATUIFunctions:SetMyMarketData(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'FillMyMarketData', data);
end

-- SCAAMATUIFunctions:SetMyOffersData
-- Sets the player market data in the UI
function SCAAMATUIFunctions:SetMyOffersData(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'FillMyOffersData', data);
end

-- SCAAMATUIFunctions:SetStorageData
-- Sets the player storage data in the UI
function SCAAMATUIFunctions:SetStorageData(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'FillStorageData', data);
end

-- SCAAMATUIFunctions:GetMyMarketItemData
-- Requests the my market item data
function SCAAMATUIFunctions:GetMyMarketItemData(elementName, instanceId, eventName, argTable)
    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATGetMyMarketItemData',
            Data = {
                myItemId = argTable[0]
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:SetMyMarketItemData
-- Sets the my market item data
function SCAAMATUIFunctions:SetMyMarketItemData(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetMyMarketItemData', data);
end

-- SCAAMATUIFunctions:GetStorageItemData
-- Requests the storage item data
function SCAAMATUIFunctions:GetStorageItemData(elementName, instanceId, eventName, argTable)
    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATGetStorageItemData',
            Data = {
                storageItemId = argTable[0],
                storageItemName = argTable[1]
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:SetStorageItemData
-- Sets the storage item data
function SCAAMATUIFunctions:SetStorageItemData(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetStorageItemData', data);
end

-- SCAAMATUIFunctions:GetMyOffersData
-- Requests the player current trade offers
function SCAAMATUIFunctions:GetMyOffersData(elementName, instanceId, eventName, argTable)
    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATGetMyOffersData',
            Data = {
                dummyData = ''
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:GetStorageData
-- Requests the player storage data
function SCAAMATUIFunctions:GetStorageData(elementName, instanceId, eventName, argTable)
    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATGetStorageData',
            Data = {
                dummyData = ''
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:AttemptItemRemoval
-- Performs an attempt to remove an item from the market
function SCAAMATUIFunctions:AttemptItemRemoval(elementName, instanceId, eventName, argTable)
    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATAttemptItemRemoval',
            Data = {
                myItemId = argTable[0]
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:GetMyMarketResponse
-- Sets and prints a response to an attempted trade
function SCAAMATUIFunctions:GetMyMarketResponse(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetMyMarketResponse', data);
end

-- SCAAMATUIFunctions:AttemptStorageItemClaim
-- Performs an attempt to claim an item
function SCAAMATUIFunctions:AttemptStorageItemClaim(elementName, instanceId, eventName, argTable)
    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATAttemptStorageItemClaim',
            Data = {
                storageItemId = argTable[0],
                storageItemName = argTable[1],
                claimAmount = argTable[2]
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:GetStorageResponse
-- Sets and prints a response to an attempted claim
function SCAAMATUIFunctions:GetStorageResponse(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetStorageResponse', data);
end

-- SCAAMATUIFunctions:GetItemData
-- Requests the player inventory
function SCAAMATUIFunctions:GetItemData(elementName, instanceId, eventName, argTable)
    local itemData = {};
    local playerItems = g_gameRules.game:GetStorageContent(g_localActorId, '');

    -- Starts adding the items to the table for the UI
    SCAAMATFillInventoryTable(playerItems, itemData, 1);

    -- Calls the UI function passing the data in JSON format
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'FillInventoryData', SCAAMATJSON.stringify(itemData));

    if (argTable[0] == 'true') then
        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'FillSelectionData', SCAAMATJSON.stringify(SCAAMATSelectionData));
    end
end

-- SCAAMATUIFunctions:AttemptAddingItem
-- Performs an attempt to add an item for trade
function SCAAMATUIFunctions:AttemptAddingItem(elementName, instanceId, eventName, argTable)
    local hasEnoughItems = false;
    local itemEntityId = false;
    local playerItems = g_gameRules.game:GetStorageContent(g_localActorId, argTable[1]);

    -- Checks if the item is unique so it finds it based on the id otherwise finds items by
    -- stack amount
    if (argTable[0] ~= -1) then

        -- Since this item is unique the quantity can't be greater than 1
        if (argTable[3] == 1) then
            if (playerItems and table.getn(playerItems) > 0) then
                for key, itemId in pairs(playerItems) do
                    item = System.GetEntity(itemId);

                    -- Checks if the raw id matches the id coming from the UI
                    if (argTable[0] == item:GetRawId()) then
                        itemEntityId = item.id;
                        hasEnoughItems = true;
                    end
                end
            end
        else
            local response = {
                true,
                true,
                'Error',
                "This item is not stackable so you can't set a quantity higher than 1"
            };

            UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetAddItemResponse', SCAAMATJSON.stringify(response));
            return;
        end
    else
        if (playerItems and table.getn(playerItems) > 0) then
            local itemAmount = 0;

            for key, itemId in pairs(playerItems) do
                item = System.GetEntity(itemId);

                -- Adds the quantity to the counter
                itemAmount = itemAmount + item.item:GetStackCount();

                if (itemAmount >= argTable[3]) then
                    hasEnoughItems = true;
                    break;
                end
            end
        end
    end

    if (hasEnoughItems == true) then
        mSendEvent(
            'Server',
            {
                Type = 'SCAAMATAttemptAddingItem',
                Data = {
                    addItemId = argTable[0],
                    addItemName = argTable[1],
                    selectedItem = argTable[2],
                    addAmount = argTable[3],
                    addAmountToTrade = argTable[4],
                    addComment = argTable[5]
                }
            },
            itemEntityId,
            false
        );
    else
        local response = {
            false,
            false,
            'Error',
            "You don't have that item or items for that amount anymore"
        };

        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetAddItemResponse', SCAAMATJSON.stringify(response));
    end
end

-- SCAAMATUIFunctions:GetAddItemResponse
-- Sets and prints a response to an attempted item addition
function SCAAMATUIFunctions:GetAddItemResponse(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetAddItemResponse', data);
end

-- SCAAMATUIFunctions:GetMessagesData
-- Requests the message data for the player
function SCAAMATUIFunctions:GetMessagesData(elementName, instanceId, eventName, argTable)

    -- Requests message data in case this information isn't stored on the client already
    if (not SCAAMATLoadedMessages) then
        mSendEvent(
            'Server',
            {
                Type = 'SCAAMATGetMessagesData',
                Data = {
                    dummyData = ''
                }
            },
            false,
            false
        );
    else
        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'FillMessageData', SCAAMATJSON.stringify(SCAAMATLoadedMessages));
    end
end

-- SCAAMATUIFunctions:FillMessageData
-- Sends the message data to the UI
function SCAAMATUIFunctions:FillMessageData(data)
    SCAAMATLoadedMessages = SCAAMATJSON.parse(data);
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'FillMessageData', data);
end

-- SCAAMATUIFunctions:OpenMessage
-- Requests the message content
function SCAAMATUIFunctions:OpenMessage(elementName, instanceId, eventName, argTable)

    -- Marks the message as read
    for key, message in pairs(SCAAMATLoadedMessages) do
        if (message[1] == argTable[0]) then
            message[6] = 1;
            break;
        end
    end

    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATOpenMessage',
            Data = {
                messageId = argTable[0]
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:SetMessageContent
-- Sends the message content to the UI
function SCAAMATUIFunctions:SetMessageContent(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetMessageContent', data);
end

-- SCAAMATUIFunctions:RemoveMessage
-- Removes a message from this terminal
function SCAAMATUIFunctions:RemoveMessage(elementName, instanceId, eventName, argTable)

    -- Marks the message as read
    for key, message in pairs(SCAAMATLoadedMessages) do
        if (message[1] == argTable[0]) then
            table.remove(SCAAMATLoadedMessages, key);
            break;
        end
    end

    mSendEvent(
        'Server',
        {
            Type = 'SCAAMATRemoveMessage',
            Data = {
                messageId = argTable[0]
            }
        },
        false,
        false
    );
end

-- SCAAMATUIFunctions:AttemptSendMessage
-- Attempts to send a message to a terminal id
function SCAAMATUIFunctions:AttemptSendMessage(elementName, instanceId, eventName, argTable)
    local data = {
        terminalId = argTable[0],
        messageTitle = argTable[1],
        messageContent = UIAction.GetVariable('mod_SCAAMAmalgamatedTerminalUI', 0, 'MessageContent')
    };

    -- Sends the JSON string in small chunks
    local JSONText = SCAAMATJSON.stringify(data);

    local JSONLength = string.len(JSONText);
    local textChunk = math.ceil(JSONLength / 1000);
    local chunkData = {};

    for i = 1, textChunk, 1 do
        if (i == 1) then
            table.insert(chunkData, string.sub(JSONText, 1, 1000));
        else
            table.insert(chunkData, string.sub(JSONText, ((i - 1) * 1000 + 1), (i * 1000)));
        end
    end

    local chunksToRemove = 4;
    local chunksToGrab = {};

    while (chunksToRemove > 0) do

        -- Checks if the table has chunks
        if (table.getn(chunkData) > 0) then
            table.insert(chunksToGrab, table.remove(chunkData, 1));
        else
            table.insert(chunksToGrab, '');
        end

        chunksToRemove = chunksToRemove - 1;
    end

    SCAAMATLocalManager.server:SendLongData(g_localActorId, 'ServerAttemptSendMessage', chunksToGrab[1], chunksToGrab[2], chunksToGrab[3], chunksToGrab[4]);
end

-- SCAAMATUIFunctions:ServerAttemptSendMessage
-- Sends a message from this player to a terminal id
function SCAAMATUIFunctions:ServerAttemptSendMessage(data, playerId)
    SCAAMATAttemptSendMessage(data, playerId);
end

-- SCAAMATUIFunctions:ServerUpdateTerminalData
-- Stores the updated terminal data on misDB
function SCAAMATUIFunctions:ServerUpdateTerminalData(data, playerId)
    SCAAMATServerUpdateTerminalData(data, playerId);
end

-- SCAAMATUIFunctions:GetMessageResponse
-- Sets and prints a response to an attempted message sending
function SCAAMATUIFunctions:GetMessageResponse(data)
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetMessageResponse', data);
end

-- SCAAMATUIFunctions:AddMessageToTerminal
-- Adds a message to the existing messages data
function SCAAMATUIFunctions:AddMessageToTerminal(data)
    local messageData = SCAAMATJSON.parse(data);
    table.insert(SCAAMATLoadedMessages, 1, messageData);

    if (table.getn(SCAAMATLoadedMessages) > 50) then
        table.remove(SCAAMATLoadedMessages, 51);
    end

    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'FillMessageData', SCAAMATJSON.stringify(SCAAMATLoadedMessages));
end

-- SCAAMATUIFunctions:ReadDisk
-- Reads the disk looking for a drive info
function SCAAMATUIFunctions:ReadDisk(elementName, instanceId, eventName, argTable)
    local floppyDiskItems = g_gameRules.game:GetStorageContent(SCAAMATAccessedTerminalId, '');

    -- Checks if the terminal accessed by this client has any floppy disks in it's inventory
    if (floppyDiskItems and table.getn(floppyDiskItems) > 0) then

        -- Checks if the terminal has an item on the requested slot then requests to the server for the
        -- floppy disk contents
        if (floppyDiskItems[argTable[0]]) then
            local floppyEntity = System.GetEntity(floppyDiskItems[argTable[0]]);

            if (floppyEntity.class == 'SCAAMGameFloppyDisk' or floppyEntity.class == 'SCAAMAppFloppyDisk') then

                -- Stores the floppy disk entity id for further validation
                SCAAMATAccessedFloppyDiskId = floppyDiskItems[argTable[0]];

                mSendEvent(
                    'Server',
                    {
                        Type = 'SCAAMATGetFloppyDataForTerminal',
                        Data = {
                            dummyData = ''
                        }
                    },
                    floppyDiskItems[argTable[0]],
                    false
                );
            else
                local response = {
                    'Error',
                    "This floppy disk doesn't contain any game or application to install"
                };
        
                UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'showModal', response[1], response[2]);
            end
        else
            local response = {
                'Error',
                "There's no floppy disk inserted on this drive"
            };
    
            UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'showModal', response[1], response[2]);
        end
    else
        local response = {
            'Error',
            "There's no floppy disks inserted on this machine"
        };

        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'showModal', response[1], response[2]);
    end
end

-- SCAAMATUIFunctions:GetFloppyData
-- Sets the floppy information to the UI
function SCAAMATUIFunctions:GetFloppyData(data)
    local JSONData = SCAAMATJSON.parse(data);

    local installData = {
        JSONData[1],
        JSONData[3],
        JSONData[2],
        false,
        true
    };

    -- Checks if the app/game has been already installed on this terminal
    for key, value in pairs(SCAAMATTerminalData.apps[JSONData[2]]) do
        if (value[1] == JSONData[1]) then
            installData[4] = true;
            break;
        end
    end

    -- Checks if the app is unsafe
    if (JSONData[1] == 'appIronSons') then
        installData[5] = false;
    end

    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetFloppyInfo', SCAAMATJSON.stringify(installData));
end

-- SCAAMATUIFunctions:InstallApp
-- Installs an application on this terminal
function SCAAMATUIFunctions:InstallApp(elementName, instanceId, eventName, argTable)

    -- Checks if the floppy disk is still in this terminal storage
    local floppyDiskItems = g_gameRules.game:GetStorageContent(SCAAMATAccessedTerminalId, '');
    local hasFloppy = false;

    if (floppyDiskItems and table.getn(floppyDiskItems) > 0) then
        for key, value in pairs(floppyDiskItems) do
            if (value == SCAAMATAccessedFloppyDiskId) then
                hasFloppy = true;
                break;
            end
        end
    else
        local response = {
            false,
            'Error',
            'The floppy disk was removed from this machine, installation failed'
        };

        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetInstallResponse', SCAAMATJSON.stringify(response));
        return;
    end

    if (hasFloppy == true) then

        -- Adds the data depending on being a game or not
        if (argTable[1] == 'applications') then

            -- Looks for an available slot to place this application
            local availableKey = 0;
            local keysUsed = {};

            for key, value in pairs(SCAAMATTerminalData.apps[argTable[1]]) do
                keysUsed[tostring(value[2])] = true;
            end

            -- Checks all the available slots to see which one isn't taken
            for i = 0, 39, 1 do
                if (not keysUsed[tostring(i)]) then
                    availableKey = i;
                    break;
                end
            end

            local installData = {
                argTable[0],
                availableKey,
                '',
                1
            };

            -- Looks for the readable name from this application
            for key, value in pairs(SCAAMATApps) do
                if (value[1] == argTable[0]) then
                    installData[3] = value[2];
                    table.insert(SCAAMATTerminalData.apps[argTable[1]], installData);
                    break;
                end
            end

            mSendEvent(
                'Server',
                {
                    Type = 'SCAAMATInstallApp',
                    Data = {
                        installData = SCAAMATJSON.stringify(installData),
                        appType = argTable[1]
                    }
                },
                SCAAMATAccessedFloppyDiskId,
                false
            );

            local response = {
                true,
                'Notice',
                'Application installed successfully. Your floppy disk has been destroyed in order to prevent copy :)',
                argTable[1],
                SCAAMATJSON.stringify(installData)
            };

            UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetInstallResponse', SCAAMATJSON.stringify(response));
        else
            local installData = {
                argTable[0],
                ''
            };

            -- Looks for the readable name from this game
            for key, value in pairs(SCAAMATGames) do
                if (value[1] == argTable[0]) then
                    installData[2] = value[2];
                    table.insert(SCAAMATTerminalData.apps[argTable[1]], installData);
                    break;
                end
            end

            mSendEvent(
                'Server',
                {
                    Type = 'SCAAMATInstallApp',
                    Data = {
                        installData = SCAAMATJSON.stringify(installData),
                        appType = argTable[1]
                    }
                },
                SCAAMATAccessedFloppyDiskId,
                false
            );

            local response = {
                true,
                'Notice',
                'Game installed successfully. Your floppy disk has been destroyed in order to prevent copy :)',
                argTable[1],
                SCAAMATJSON.stringify(installData)
            };

            UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetInstallResponse', SCAAMATJSON.stringify(response));
        end
    else
        local response = {
            false,
            'Error',
            'The floppy disk was removed from this machine, installation failed'
        };

        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'GetInstallResponse', SCAAMATJSON.stringify(response));
    end

    SCAAMATAccessedFloppyDiskId = nil;
end

-- SCAAMATUIFunctions:GetCamerasData
-- Gets the camera info for this terminal's base
function SCAAMATUIFunctions:GetCamerasData(elementName, instanceId, eventName, argTable)
    local terminal = System.GetEntity(SCAAMATAccessedTerminalId);
    local plotsign = System.GetNearestEntityByClass(terminal:GetWorldPos(), 600, 'PlotSign');
    SCAAMATCameraParts = {};
    local cameraData = {};
    local cameraCounter = 1;
    local selectedCamera = -2;

    if (SCAAMATSelectedCamera ~= nil) then
        selectedCamera = -1;
    end

    local numParts = plotsign.plotsign:GetPartCount();

    -- Stores the camera parts and their positions
    for p = 0, numParts - 1, 1 do
        local partId = plotsign.plotsign:GetPartId(p);

        if (plotsign.plotsign:GetPartTypeId(partId) == 7635) then
            local camPos = plotsign.plotsign:GetPartWorldPos(partId);
            local camDir = plotsign:GetSlotWorldDir(partId + 10);
            NormalizeVector(camDir);

            -- Rotates the direction 10 degrees
            local degrees = 10;
            -- Transforms degrees to radians
            local theta = -math.rad(degrees);
            local camDir = plotsign:GetSlotWorldDir(partId + 10);
            local x = camDir.x;
            camDir.x = camDir.x * math.cos(theta) - camDir.y * math.sin(theta);
            camDir.y = x * math.sin(theta) + camDir.y * math.cos(theta);

            local vForwardOffset = {x=0, y=0, z=0};
            local vPointingPosition = {x=0, y=0, z=0};
            FastScaleVector(vForwardOffset, camDir, 0.62);
            FastSumVectors(vPointingPosition, vForwardOffset, camPos);
            camPos = vPointingPosition;

            -- camPos.z = camPos.z - 0.15;
            SCAAMATCameraParts[tostring(camPos.x) .. tostring(camPos.y) .. tostring(camPos.z)] = {
                partId = partId,
                position = camPos,
                direction = camDir,
                plotsignId = plotsign.id
            };

            table.insert(cameraData, {
                cameraCounter,
                tostring(camPos.x) .. tostring(camPos.y) .. tostring(camPos.z)
            });

            if (SCAAMATSelectedCamera == tostring(camPos.x) .. tostring(camPos.y) .. tostring(camPos.z)) then
                selectedCamera = cameraCounter;
            end

            cameraCounter = cameraCounter + 1;
        end
    end

    UIAction.SetVisible('UsableMenu', -1, '_root', false);

    -- Returns the camera data to the UI
    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FillCamData', SCAAMATJSON.stringify(cameraData), selectedCamera);
end

-- SCAAMATUIFunctions:ChangeCamera
-- Changes the camera pos based on the camera position coming from the UI
function SCAAMATUIFunctions:ChangeCamera(elementName, instanceId, eventName, argTable)

    -- Checks if the camera position exists or will just send a notification of a camera not found
    if (SCAAMATCameraParts[argTable[0]]) then
        local plotsign = System.GetEntity(SCAAMATCameraParts[argTable[0]].plotsignId);
        local moveToDirection = new(SCAAMATCameraParts[argTable[0]].direction);
        moveToDirection.z = -0.08;
        CryAction.SetViewCamera(SCAAMATCameraParts[argTable[0]].position, moveToDirection);
        CryAction.SetViewCamera(SCAAMATCameraParts[argTable[0]].position, moveToDirection);
        SCAAMATSelectedCamera = argTable[0];
        SCAAMATSelectedCameraPosDir = {
            SCAAMATCameraParts[argTable[0]].position,
            moveToDirection
        };
        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'SetCameraFound');
        UIAction.SetVisible('UsableMenu', -1, '_root', false);
    else
        CryAction.ResetToNormalCamera();
        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'SetCameraNotFound');
        self:GetCamerasData('mod_SCAAMAmalgamatedTerminalUI', 0, 'GetCamerasData', {});
        SCAAMATSelectedCamera = nil;
        SCAAMATSelectedCameraPosDir = nil;
        UIAction.SetVisible('UsableMenu', -1, '_root', true);
    end

    -- Kills then starts a timer to check for changes on the cameras
    if (SCAAMATCameraTimerId) then
        Script.KillTimer(SCAAMATCameraTimerId);
        SCAAMATCameraTimerId = nil;
    end

    -- Refreshes the cameras every 5 seconds
    SCAAMATCameraTimerId = Script.SetTimerForFunction(3000, 'SCAAMATCheckForCameraChanges', {});
end

-- SCAAMATCheckForCameraChanges
-- Checks for camera changes after a delay
function SCAAMATCheckForCameraChanges(dummyData)
    local terminal = System.GetEntity(SCAAMATAccessedTerminalId);
    local plotsign = System.GetNearestEntityByClass(terminal:GetWorldPos(), 600, 'PlotSign');
    local newCameraParts = {};
    local numParts = plotsign.plotsign:GetPartCount();

    -- Stores the camera parts and their positions
    for p = 0, numParts - 1, 1 do
        local partId = plotsign.plotsign:GetPartId(p);

        if (plotsign.plotsign:GetPartTypeId(partId) == 7635) then
            local camPos = plotsign.plotsign:GetPartWorldPos(partId);
            local camDir = plotsign:GetSlotWorldDir(partId + 10);
            NormalizeVector(camDir);

            -- Rotates the direction 10 degrees
            local degrees = 10;
            -- Transforms degrees to radians
            local theta = -math.rad(degrees);
            local camDir = plotsign:GetSlotWorldDir(partId + 10);
            local x = camDir.x;
            camDir.x = camDir.x * math.cos(theta) - camDir.y * math.sin(theta);
            camDir.y = x * math.sin(theta) + camDir.y * math.cos(theta);

            local vForwardOffset = {x=0, y=0, z=0};
            local vPointingPosition = {x=0, y=0, z=0};
            FastScaleVector(vForwardOffset, camDir, 0.62);
            FastSumVectors(vPointingPosition, vForwardOffset, camPos);
            camPos = vPointingPosition;

            -- camPos.z = camPos.z - 0.15;
            newCameraParts[tostring(camPos.x) .. tostring(camPos.y) .. tostring(camPos.z)] = {
                partId = partId,
                position = camPos,
                direction = camDir,
                plotsignId = plotsign.id
            };
        end
    end

    -- Checks if the camera data tables are different to perform a new camera update
    if (SCAAMATTableEquals(SCAAMATCameraParts, newCameraParts, false) == false) then
        SCAAMATUIFunctions:GetCamerasData('mod_SCAAMAmalgamatedTerminalUI', 0, 'GetCamerasData', {});
    end

    SCAAMATCameraTimerId = Script.SetTimerForFunction(3000, 'SCAAMATCheckForCameraChanges', {});
end

-- SCAAMATUIFunctions:StopCameras
-- Stops the camera app and returns the player camera to normal
function SCAAMATUIFunctions:StopCameras(elementName, instanceId, eventName, argTable)

    -- Kills the timer
    if (SCAAMATCameraTimerId) then
        Script.KillTimer(SCAAMATCameraTimerId);
        SCAAMATCameraTimerId = nil;
    end

    SCAAMATSelectedCamera = nil;
    SCAAMATSelectedCameraPosDir = nil;

    CryAction.ResetToNormalCamera();
    UIAction.SetVisible('UsableMenu', -1, '_root', true);
end

-- SCAAMATUIFunctions:ChangeCameraDirection
-- Changes the camera direction to a limited x and y rotation
function SCAAMATUIFunctions:ChangeCameraDirection(elementName, instanceId, eventName, argTable)

    -- Checks if the camera position exists or will just send a notification of a camera not found
    if (SCAAMATCameraParts[SCAAMATSelectedCamera]) then

        -- Decides which direction is gonna rotate around depending on the arrow clicked
        local degrees = 45;
        if (argTable[0] == 'left') then
            degrees = -45;
        end

        -- Transforms degrees to radians
        local theta = -math.rad(degrees);
        local camDir = SCAAMATSelectedCameraPosDir[2];
        local x = camDir.x;
        camDir.x = camDir.x * math.cos(theta) - camDir.y * math.sin(theta);
        camDir.y = x * math.sin(theta) + camDir.y * math.cos(theta);
        camDir.z = -0.08;
        SCAAMATSelectedCameraPosDir[2] = camDir;
        CryAction.SetViewCamera(SCAAMATSelectedCameraPosDir[1], camDir);
        CryAction.SetViewCamera(SCAAMATSelectedCameraPosDir[1], camDir);
        UIAction.SetVisible('UsableMenu', -1, '_root', false);
    else
        CryAction.ResetToNormalCamera();
        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'SetCameraNotFound');
        self:GetCamerasData('mod_SCAAMAmalgamatedTerminalUI', 0, 'GetCamerasData', {});
        SCAAMATSelectedCamera = nil;
        SCAAMATSelectedCameraPosDir = nil;
        UIAction.SetVisible('UsableMenu', -1, '_root', true);
    end
end

-- SCAAMATUIFunctions:ReadConsoleDisk
-- Reads data from the terminal inventory
function SCAAMATUIFunctions:ReadConsoleDisk(elementName, instanceId, eventName, argTable)
    local floppyDiskItems = g_gameRules.game:GetStorageContent(SCAAMATAccessedTerminalId, '');

    -- Checks if the terminal accessed by this client has any floppy disks in it's inventory
    if (floppyDiskItems and table.getn(floppyDiskItems) > 0) then

        -- Checks if the terminal has an item on the requested slot then requests to the server for the
        -- floppy disk contents
        if (floppyDiskItems[argTable[0]]) then
            local floppyEntity = System.GetEntity(floppyDiskItems[argTable[0]]);

            if (floppyEntity.class == 'SCAAMEncryptedFloppyDisk') then

                -- Stores the floppy disk entity id for further validation
                SCAAMATAccessedFloppyDiskId = floppyDiskItems[argTable[0]];

                local response = {
                    true
                };
        
                UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetDriveResponse', SCAAMATJSON.stringify(response));
            else
                local response = {
                    false,
                    "This floppy disk doesn't contain any data to decrypt"
                };
        
                UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetDriveResponse', SCAAMATJSON.stringify(response));
            end
        else
            local response = {
                false,
                "There's no floppy disk inserted on this drive"
            };
    
            UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetDriveResponse', SCAAMATJSON.stringify(response));
        end
    else
        local response = {
            false,
            "There's no floppy disk inserted on this drive"
        };

        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetDriveResponse', SCAAMATJSON.stringify(response));
    end
end

-- SCAAMATUIFunctions:GetEncryptedDiskData
-- Gets the decrypted data from this floppy disk
function SCAAMATUIFunctions:GetEncryptedDiskData(elementName, instanceId, eventName, argTable)

    -- Checks if the floppy disk is still in this terminal storage
    local floppyDiskItems = g_gameRules.game:GetStorageContent(SCAAMATAccessedTerminalId, '');

    if (floppyDiskItems and table.getn(floppyDiskItems) > 0) then
        for key, value in pairs(floppyDiskItems) do
            if (value == SCAAMATAccessedFloppyDiskId) then

                -- Sets the floppy information to the UI in the Iron Sons App
                local decryptedMessage = '';
                local messagePicked = {};

                -- Builds the message based on randomized names and messages
                decryptedMessage = decryptedMessage .. SCAAMATConsoleDialogs.greeting[math.random(table.getn(SCAAMATConsoleDialogs.greeting))];

                -- Builds the message more professionally or not based on the greeting
                if (decryptedMessage == '' or decryptedMessage == 'Greetings ' or decryptedMessage == 'Good day ') then
                    local randomInitialContent = math.random(2);

                    if (randomInitialContent == 1) then
                        decryptedMessage = decryptedMessage .. SCAAMATConsoleDialogs.title[math.random(table.getn(SCAAMATConsoleDialogs.title))];
                        decryptedMessage = decryptedMessage .. ' ' .. SCAAMATConsoleDialogs.lastname[math.random(table.getn(SCAAMATConsoleDialogs.lastname))] .. '.\n';

                        -- Gets the message data, including the content the stash will contain
                        messagePicked = SCAAMATConsoleDialogs.messageFormal[math.random(table.getn(SCAAMATConsoleDialogs.messageFormal))];
                    else
                        decryptedMessage = decryptedMessage .. SCAAMATConsoleDialogs.firstname[math.random(table.getn(SCAAMATConsoleDialogs.firstname))] .. '.\n';

                        -- Gets the message data, including the content the stash will contain
                        messagePicked = SCAAMATConsoleDialogs.message[math.random(table.getn(SCAAMATConsoleDialogs.message))];
                    end

                    decryptedMessage = decryptedMessage .. messagePicked[2];

                    decryptedMessage = ' ' .. decryptedMessage .. ' ' .. 'HEREGOESCOORDINATE';

                    -- Finally adds the second part of the message
                    decryptedMessage = decryptedMessage .. messagePicked[3] .. '\n';

                    if (randomInitialContent == 1) then
                        decryptedMessage = decryptedMessage .. SCAAMATConsoleDialogs.title[math.random(table.getn(SCAAMATConsoleDialogs.title))];
                        decryptedMessage = decryptedMessage .. ' ' .. SCAAMATConsoleDialogs.lastname[math.random(table.getn(SCAAMATConsoleDialogs.lastname))] .. '.';
                    else
                        decryptedMessage = decryptedMessage .. SCAAMATConsoleDialogs.firstname[math.random(table.getn(SCAAMATConsoleDialogs.firstname))];
                    end
                else
                    decryptedMessage = decryptedMessage .. SCAAMATConsoleDialogs.firstname[math.random(table.getn(SCAAMATConsoleDialogs.firstname))] .. '.\n';

                    -- Gets the message data, including the content the stash will contain
                    messagePicked = SCAAMATConsoleDialogs.message[math.random(table.getn(SCAAMATConsoleDialogs.message))];
                    decryptedMessage = decryptedMessage .. messagePicked[2];

                    decryptedMessage = ' ' .. decryptedMessage .. ' ' .. 'HEREGOESCOORDINATE';

                    -- Finally adds the second part of the message
                    decryptedMessage = decryptedMessage .. messagePicked[3] .. '\n';
                    decryptedMessage = decryptedMessage .. SCAAMATConsoleDialogs.firstname[math.random(table.getn(SCAAMATConsoleDialogs.firstname))];
                end

                -- Sends the stash content and coordinates to store on the server
                mSendEvent(
                    'Server',
                    {
                        Type = 'SCAAMATAddStashCoordinate',
                        Data = {
                            stashContent = messagePicked[1]
                        }
                    },
                    SCAAMATAccessedFloppyDiskId,
                    false
                );

                SCAAMATDecryptedMessage = decryptedMessage;
                break;
            end
        end
    else
        local response = {
            false,
            "There's no floppy disk inserted on this drive"
        };

        UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetDataResponse', SCAAMATJSON.stringify(response));
    end

    SCAAMATAccessedFloppyDiskId = nil;
end

-- SCAAMATUIFunctions:GetCoordinateData
-- Sets the coordinate information and message to the UI
function SCAAMATUIFunctions:GetCoordinateData(data)
    local JSONData = SCAAMATJSON.parse(data);

    -- Converts the coordinate to a readable string
    local coordinateToString = 'x: ' .. JSONData[1].x .. ', y: ' .. JSONData[1].y .. ', z: ' .. JSONData[1].z;

    SCAAMATDecryptedMessage = SCAAMATDecryptedMessage:gsub('HEREGOESCOORDINATE', coordinateToString);

    local response = {
        true,
        SCAAMATDecryptedMessage
    };

    UIAction.CallFunction('mod_SCAAMAmalgamatedTerminalUI', 0, 'FireChildMCFunction', 'SetDataResponse', SCAAMATJSON.stringify(response));
end

-- SCAAMATUIFunctions:SelectPermission
-- Changes the permission from an application
function SCAAMATUIFunctions:SelectPermission(elementName, instanceId, eventName, argTable)
    SCAAMATTerminalChanged = true;

    for key, app in pairs(SCAAMATTerminalData.apps.applications) do

        -- Searches the application that is gonna be permission modified
        if (app[1] == argTable[0]) then
            app[4] = argTable[1];
            break;
        end
    end
end

-- SCAAMATUIFunctions:ChangeBackground
-- Changes the background of the terminal
function SCAAMATUIFunctions:ChangeBackground(elementName, instanceId, eventName, argTable)
    SCAAMATTerminalChanged = true;
    SCAAMATTerminalData.data.background = argTable[0];
end

-- SCAAMATUIFunctions:MoveApplications
-- Moves one application or two from a slot to another
function SCAAMATUIFunctions:MoveApplications(elementName, instanceId, eventName, argTable)
    local preChangesTerminalData = new(SCAAMATTerminalData);

    for key, app in pairs(SCAAMATTerminalData.apps.applications) do

        -- Searches the applications that are gonna be slot modified
        if (app[1] == argTable[0]) then
            app[2] = argTable[1];
        elseif (app[1] == argTable[2]) then
            app[2] = argTable[3];
        end
    end

    if (SCAAMATTableEquals(preChangesTerminalData, SCAAMATTerminalData, false) == false) then
        SCAAMATTerminalChanged = true;
    end
end

-- SCAAMATUIFunctions:ReactivateFilters
-- Disables the filters so the player can move again
function SCAAMATUIFunctions:ReactivateFilters()
    ActionMapManager.EnableActionFilter('ladder_only', false);
end

---------------------------------------------------------------------------------------
--------------------------- SMART UI TABLE FUNCTIONS END ------------------------------
---------------------------------------------------------------------------------------

-- SCAAMATSendClientData
-- Sends all the information in chunks to the client before performing the function
function SCAAMATSendClientData(allTheInfo, operation, playerId)
    local player = System.GetEntity(playerId);
    local playerChannel = player.actor:GetChannel();

    -- Sends the JSON string in small chunks
    local JSONText = SCAAMATJSON.stringify(allTheInfo);

    local JSONLength = string.len(JSONText);
    local textChunk = math.ceil(JSONLength / 1000);
    local chunkData = {};

    for i = 1, textChunk, 1 do
        if (i == 1) then
            table.insert(chunkData, string.sub(JSONText, 1, 1000));
        else
            table.insert(chunkData, string.sub(JSONText, ((i - 1) * 1000 + 1), (i * 1000)));
        end
    end

    -- Grabs the first 4 chunks of the table and calls the function to fill data
    -- If there's still chunks left, the client will call another server function to retrieve
    -- these chunks
    local chunksToRemove = 4;
    local chunksToGrab = {};
    local stillHasChunks = false;
    local insertedChunks = 0;

    while (chunksToRemove > 0) do

        -- Checks if the table has chunks
        if (table.getn(chunkData) > 0) then
            table.insert(chunksToGrab, table.remove(chunkData, 1));
            insertedChunks = insertedChunks + 1;
        else
            table.insert(chunksToGrab, '');
        end

        chunksToRemove = chunksToRemove - 1;
    end

    -- Checks if the table still has chunks
    if (table.getn(chunkData) > 0) then
        stillHasChunks = true;
        player.SCAAMATTotalChunks = textChunk;
        player.SCAAMATRemainingChunks = chunkData;
    end

    SCAAMATManager.onClient:BuildTheDataUI(playerChannel, operation, stillHasChunks, insertedChunks, textChunk, chunksToGrab[1], chunksToGrab[2], chunksToGrab[3], chunksToGrab[4]);
end

-- SCAAMATRequestMoreData
-- Retrieves the remaining chunks from the temporary player data
function SCAAMATRequestMoreData(playerId, totalChunks, operation)
    local player = System.GetEntity(playerId);
    local playerChannel = player.actor:GetChannel();

    -- Grabs the first 4 chunks of the table and calls the function to fill data
    -- If there's still chunks left, the client will call another server function to retrieve
    -- these chunks
    local chunksToRemove = 4;
    local chunksToGrab = {};
    local stillHasChunks = false;
    local insertedChunks = 0;

    while (chunksToRemove > 0) do

        -- Checks if the table has chunks
        if (table.getn(player.SCAAMBRRemainingChunks) > 0) then
            table.insert(chunksToGrab, table.remove(player.SCAAMBRRemainingChunks, 1));
            insertedChunks = insertedChunks + 1;
        else
            table.insert(chunksToGrab, '');
        end

        chunksToRemove = chunksToRemove - 1;
    end

    -- Checks if the table still has chunks
    if (table.getn(player.SCAAMBRRemainingChunks) > 0) then
        stillHasChunks = true;
        player.SCAAMBRTotalChunks = totalChunks;
    end

    SCAAMATManager.onClient:BuildTheDataUI(playerChannel, operation, stillHasChunks, insertedChunks, totalChunks, chunksToGrab[1], chunksToGrab[2], chunksToGrab[3], chunksToGrab[4]);
end

-- SCAAMATRevivePlayer
-- Sends all the initial information and spawns the mod manager entity in case it's not present
function SCAAMATRevivePlayer(playerId)
    if (not SCAAMATManager) then
        SCAAMATManager = ISM.SpawnItem('SCAAMAmalgamatedTerminalManager', {x = 1000, y = 1000, z = 500});
    
        -- Sets the map data
        SCAAMATMapName = System.GetCVar('sv_map');
        SCAAMATMapScale = 0;

        if (System.IsValidMapPos({x = 8692, y = 8692, z = 100}) == true) then
            SCAAMATMapScale = 8192;
        elseif (System.IsValidMapPos({x = 4596, y = 4596, z = 100}) == true) then
            SCAAMATMapScale = 4096;
        elseif (System.IsValidMapPos({x = 2548, y = 2548, z = 100}) == true) then
            SCAAMATMapScale = 2048;
        elseif (System.IsValidMapPos({x = 1524, y = 1524, z = 100}) == true) then
            SCAAMATMapScale = 1024;
        elseif (System.IsValidMapPos({x = 1012, y = 1012, z = 100}) == true) then
            SCAAMATMapScale = 512;
        elseif (System.IsValidMapPos({x = 756, y = 756, z = 100}) == true) then
            SCAAMATMapScale = 256;
        elseif (System.IsValidMapPos({x = 628, y = 628, z = 100}) == true) then
            SCAAMATMapScale = 128;
        end

        if (SCAAMATMapName == 'canyonlands') then
            SCAAMATMapScale = 5537;
        end
    end

    local customData = {};

    if (SCAAMATParamsTable:GetPage('addedGames')[1][1] ~= 'placeholder') then
        customData['games'] = SCAAMATParamsTable:GetPage('addedGames');
    end

    if (SCAAMATParamsTable:GetPage('addedBackgrounds')[1] ~= 'placeholder') then
        customData['backgrounds'] = SCAAMATParamsTable:GetPage('addedBackgrounds');
    end

    SCAAMATSendClientData({rawData = SCAAMATJSON.stringify(customData)}, 'InitPlayer', playerId);
end

-- Calling the Miscreated Respawn player to set the RMI entity manager
RegisterCallbackReturnAware(
    Miscreated,
    'RevivePlayer',
    function (self, ret, playerId)
        SCAAMATRevivePlayer(playerId);

        return ret;
    end,
    nil
);

-- Calling the Player hit function to close the teminal UI in case it's opened while unconcious
-- or killed
RegisterCallback(
    Player.Server,
    'OnHit',
    nil,
    function (player, hit)
        local playerKilled = hit.target;

        if (playerKilled and playerKilled.player) then
            if (playerKilled.lastHealth <= 0) then
                SCAAMATSendClientData({dummyData = ''}, 'CloseUI', playerKilled.id);
            else
                local playerData = {
                    PlayerId = playerKilled.id
                };
                Script.SetTimerForFunction(750, 'SCAAMATCheckUnconsciousness', playerData);
            end
        end
    end
);