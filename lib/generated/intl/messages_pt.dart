// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'pt';

  static String m17(error) => "Erro ao iniciar sessão com a Apple: ${error}";

  static String m1(authMethod) =>
      "Autentique-se com ${authMethod} para aceder à Habo";

  static String m2(authMethod) =>
      "Autentique-se com ${authMethod} para aceder aos seus hábitos";

  static String m3(authMethod) => "Proteger a aplicação com ${authMethod}";

  static String m4(title) => "A categoria \"${title}\" já existe";

  static String m5(title) => "Categoria \"${title}\" criada com sucesso";

  static String m6(title) => "Categoria \"${title}\" apagada com sucesso";

  static String m7(title) => "Categoria \"${title}\" atualizada com sucesso";

  static String m18(e) =>
      "Não foi possível ligar ao servidor. Verifique o URL, a chave anon e se a migração da Habo foi aplicada.\n\nErro: ${e}";

  static String m8(current, unit) => "Atual: ${current} ${unit}";

  static String m9(title) =>
      "Tem certeza que deseja apagar \"${title}\"?\n\nIsto removerá a categoria de todos os hábitos que a utilizam.";

  static String m19(error) => "Erro: ${error}";

  static String m10(error) => "Falha ao apagar a categoria: ${error}";

  static String m20(error) => "Falha ao reenviar: ${error}";

  static String m11(error) => "Falha ao gravar a categoria: ${error}";

  static String m21(count) => "${count} hábitos";

  static String m22(days, plural) =>
      "Última sincronização há ${days} ${Intl.select(plural, {'s': 'dias', 'other': 'dia'})}";

  static String m23(hours) => "Última sincronização há ${hours} h";

  static String m24(minutes) => "Última sincronização há ${minutes} min";

  static String m12(title) => "Sem hábitos em \"${title}\"";

  static String m13(current, target, unit) => "${current} / ${target} ${unit}";

  static String m25(seconds) => "Reenviar em ${seconds} s";

  static String m26(date) =>
      "Isto substituirá todos os dados atuais pela cópia de segurança de ${date}.\n\nEsta ação não pode ser anulada.";

  static String m27(error) => "Falha ao restaurar: ${error}";

  static String m14(count) => "Categorias selecionadas (${count})";

  static String m15(target, unit) => "Objetivo: ${target} ${unit}";

  static String m0(theme) =>
      "${Intl.select(theme, {'device': 'Dispositivo', 'light': 'Claro', 'dark': 'Escuro', 'oled': 'Escuro OLED', 'other': 'Dispositivo'})}";

  static String m28(time) => "Hoje às ${time}";

  static String m29(weekday, time) => "${weekday} às ${time}";

  static String m16(version) => "Versão {${version}}";

  static String m30(time) => "Ontem às ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Sobre"),
    "accountPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Palavra-passe da conta alterada com sucesso",
    ),
    "accountabilityPartner": MessageLookupByLibrary.simpleMessage(
      "Parceiro de responsabilidade",
    ),
    "add": MessageLookupByLibrary.simpleMessage("Adicionar"),
    "addCategory": MessageLookupByLibrary.simpleMessage("Adicionar Categoria"),
    "advancedHabitBuilding": MessageLookupByLibrary.simpleMessage(
      "Criação avançada de hábitos",
    ),
    "advancedHabitBuildingDescription": MessageLookupByLibrary.simpleMessage(
      "Esta secção ajuda-te a definir os teus hábitos através de um círculo de hábitos. Deves definir os estímulos, rotinas e recompensas para cada hábito.",
    ),
    "all": MessageLookupByLibrary.simpleMessage("Todos"),
    "allCategories": MessageLookupByLibrary.simpleMessage("Todas categorias"),
    "allHabitsWillBeReplaced": MessageLookupByLibrary.simpleMessage(
      "Os hábitos serão substituídos pelos hábitos da cópia de segurança.",
    ),
    "allow": MessageLookupByLibrary.simpleMessage("Permitir"),
    "alreadyHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Já tem uma conta? ",
    ),
    "anUnexpectedErrorOccurred": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro inesperado",
    ),
    "anUnexpectedErrorOccurredTryAgain": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro inesperado. Por favor, tente novamente.",
    ),
    "anonKeyIsRequired": MessageLookupByLibrary.simpleMessage(
      "A chave anon é obrigatória",
    ),
    "appNotifications": MessageLookupByLibrary.simpleMessage(
      "Notificações da aplicação",
    ),
    "appNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Formato das notificações da aplicação",
    ),
    "appleSignInError": m17,
    "archive": MessageLookupByLibrary.simpleMessage("Arquivar"),
    "archiveHabit": MessageLookupByLibrary.simpleMessage("Arquivar Hábito"),
    "archivedHabits": MessageLookupByLibrary.simpleMessage(
      "Hábitos Arquivados",
    ),
    "at7AM": MessageLookupByLibrary.simpleMessage("Às 7h"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Autenticação"),
    "authenticateToAccess": MessageLookupByLibrary.simpleMessage(
      "Autentique-se para aceder à Habo",
    ),
    "authenticateToEnable": MessageLookupByLibrary.simpleMessage(
      "Autentique-se para ativar o bloqueio por biometria",
    ),
    "authenticating": MessageLookupByLibrary.simpleMessage("A autenticar…"),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Erro de autenticação",
    ),
    "authenticationFailedMessage": m1,
    "authenticationPrompt": m2,
    "authenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Autenticação necessária",
    ),
    "automaticCloudBackups": MessageLookupByLibrary.simpleMessage(
      "Cópias de segurança automáticas na nuvem",
    ),
    "backToSignIn": MessageLookupByLibrary.simpleMessage(
      "Voltar ao início de sessão",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Cópia de segurança"),
    "backupCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Backup criado com sucesso!",
    ),
    "backupFailed": MessageLookupByLibrary.simpleMessage("Backup malsucedido!"),
    "backupFailedError": MessageLookupByLibrary.simpleMessage(
      "Erro ao criar cópia de segurança.",
    ),
    "backupRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Cópia de segurança restaurada com sucesso!",
    ),
    "biometric": MessageLookupByLibrary.simpleMessage("Biometria"),
    "biometricAuthenticationRequired": MessageLookupByLibrary.simpleMessage(
      "Autenticação por biometria obrigatória",
    ),
    "biometricAuthenticationSucceeded": MessageLookupByLibrary.simpleMessage(
      "Autenticação biométrica realizada",
    ),
    "biometricLock": MessageLookupByLibrary.simpleMessage(
      "Bloqueio biométrico",
    ),
    "biometricLockDescription": m3,
    "biometricLockDisabled": MessageLookupByLibrary.simpleMessage(
      "Bloqueio por biometria desativado",
    ),
    "biometricLockEnabled": MessageLookupByLibrary.simpleMessage(
      "Bloqueio por biometria ativado",
    ),
    "biometricNotRecognized": MessageLookupByLibrary.simpleMessage(
      "Biometria não reconhecida, tente novamente",
    ),
    "biometricRequired": MessageLookupByLibrary.simpleMessage(
      "Biometria obrigatória",
    ),
    "booleanHabit": MessageLookupByLibrary.simpleMessage(
      "Verificável (Sim/Não)",
    ),
    "buildingBetterHabits": MessageLookupByLibrary.simpleMessage(
      "Construir Hábitos Melhores",
    ),
    "buyMeACoffee": MessageLookupByLibrary.simpleMessage("Paga-me um café"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "categories": MessageLookupByLibrary.simpleMessage("Categorias"),
    "category": MessageLookupByLibrary.simpleMessage("Categoria"),
    "categoryAlreadyExists": m4,
    "categoryCreatedSuccessfully": m5,
    "categoryDeletedSuccessfully": m6,
    "categoryName": MessageLookupByLibrary.simpleMessage("Nome da categoria"),
    "categoryUpdatedSuccessfully": m7,
    "changeAccountPassword": MessageLookupByLibrary.simpleMessage(
      "Alterar palavra-passe da conta",
    ),
    "changeMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Alterar palavra-passe mestra",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "Alterar palavra-passe",
    ),
    "check": MessageLookupByLibrary.simpleMessage("Verificar"),
    "checkEmailForPasswordReset": MessageLookupByLibrary.simpleMessage(
      "Verifique o seu e-mail para encontrar a ligação de reposição da palavra-passe.",
    ),
    "checkEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Verifique o seu e-mail para encontrar a ligação de reposição da palavra-passe.",
    ),
    "checkYourEmail": MessageLookupByLibrary.simpleMessage(
      "Verifique o seu e-mail",
    ),
    "chooseBackupToRestore": MessageLookupByLibrary.simpleMessage(
      "Escolha uma cópia de segurança para restaurar",
    ),
    "chooseStrongPassword": MessageLookupByLibrary.simpleMessage(
      "Escolha uma palavra-passe forte para a sua conta.",
    ),
    "clickLinkInEmailToVerify": MessageLookupByLibrary.simpleMessage(
      "Clique na ligação no e-mail para verificar a sua conta e, em seguida, volte aqui e toque no botão abaixo.",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Fechar"),
    "complete": MessageLookupByLibrary.simpleMessage("Completo"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirme a palavra-passe nova",
    ),
    "confirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirme a palavra-passe",
    ),
    "congratulationsReward": MessageLookupByLibrary.simpleMessage(
      "Parabéns! Eis a tua recompensa:",
    ),
    "connectedToCloud": MessageLookupByLibrary.simpleMessage("Ligado à nuvem"),
    "connectedToCustomServer": MessageLookupByLibrary.simpleMessage(
      "Ligado a um servidor personalizado",
    ),
    "connectedToHaboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Ligado à Habo Cloud (predefinido)",
    ),
    "continueWithApple": MessageLookupByLibrary.simpleMessage(
      "Continuar com a Apple",
    ),
    "continueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continuar com a Google",
    ),
    "copyright": MessageLookupByLibrary.simpleMessage("Habo ©2023"),
    "couldNotConnectToServer": m18,
    "create": MessageLookupByLibrary.simpleMessage("Criar"),
    "createAccount": MessageLookupByLibrary.simpleMessage("Criar conta"),
    "createAccountToBackupAndSync": MessageLookupByLibrary.simpleMessage(
      "Crie uma conta para fazer cópias de segurança e sincronizar.",
    ),
    "createCategory": MessageLookupByLibrary.simpleMessage("Criar categoria"),
    "createFirstCategory": MessageLookupByLibrary.simpleMessage(
      "Crie a sua primeira categoria para organizar os seus hábitos",
    ),
    "createHabit": MessageLookupByLibrary.simpleMessage("Criar Hábito"),
    "createHabitForCategory": MessageLookupByLibrary.simpleMessage(
      "Crie um hábito e atribua-o a esta categoria",
    ),
    "createMasterPassword": MessageLookupByLibrary.simpleMessage(
      "Criar palavra-passe mestra",
    ),
    "createYourFirstHabit": MessageLookupByLibrary.simpleMessage(
      "Cria o teu primeiro hábito.",
    ),
    "cue": MessageLookupByLibrary.simpleMessage("Estímulo"),
    "cueDescription": MessageLookupByLibrary.simpleMessage(
      "é o que desencadeia o hábito. Pode ser uma hora específica, um local, sensação ou evento.",
    ),
    "cueNumbered": MessageLookupByLibrary.simpleMessage("1. Estímulo"),
    "currentPassword": MessageLookupByLibrary.simpleMessage(
      "Palavra-passe atual",
    ),
    "currentPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "A palavra-passe atual é obrigatória",
    ),
    "currentProgress": m8,
    "currentStreak": MessageLookupByLibrary.simpleMessage("Sequência atual"),
    "customServer": MessageLookupByLibrary.simpleMessage(
      "Servidor personalizado",
    ),
    "dan": MessageLookupByLibrary.simpleMessage("Dan"),
    "dataBeingSynchronized": MessageLookupByLibrary.simpleMessage(
      "Os seus dados estão a ser sincronizados",
    ),
    "date": MessageLookupByLibrary.simpleMessage("Data"),
    "defineYourHabits": MessageLookupByLibrary.simpleMessage(
      "Define os teus hábitos",
    ),
    "defineYourHabitsDescription": MessageLookupByLibrary.simpleMessage(
      "Para manter mais facilmente os hábitos, podes definir:",
    ),
    "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage("Apagar conta"),
    "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
      "Esta ação é permanente e não pode ser anulada. Os seguintes dados serão eliminados permanentemente:",
    ),
    "deleteCategory": MessageLookupByLibrary.simpleMessage("Apagar categoria"),
    "deleteCategoryConfirmation": m9,
    "deleteCloudBackupsAndSyncData": MessageLookupByLibrary.simpleMessage(
      "Cópias de segurança na nuvem e dados de sincronização",
    ),
    "deleteEncryptionKeysAndProfile": MessageLookupByLibrary.simpleMessage(
      "Chaves de encriptação e perfil",
    ),
    "deleteHabitsAndTrackingData": MessageLookupByLibrary.simpleMessage(
      "Todos os seus hábitos e dados de acompanhamento",
    ),
    "deleteSubscriptionManagedSeparately": MessageLookupByLibrary.simpleMessage(
      "Subscrição (gerida separadamente pela loja)",
    ),
    "deleteYourAccount": MessageLookupByLibrary.simpleMessage(
      "Eliminar a sua conta",
    ),
    "deleteYourAccountAndLoginCredentials":
        MessageLookupByLibrary.simpleMessage(
          "A sua conta e as credenciais de início de sessão",
        ),
    "deviceCredentialsRequired": MessageLookupByLibrary.simpleMessage(
      "Credenciais do dispositivo necessárias",
    ),
    "devicePinPatternPassword": MessageLookupByLibrary.simpleMessage(
      "PIN, padrão ou palavra-passe do dispositivo",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Aviso Legal"),
    "disconnectFromSelfHosted": MessageLookupByLibrary.simpleMessage(
      "Isto desligará do seu servidor autoalojado e voltará ao servidor predefinido Habo Cloud. Terá de iniciar sessão novamente.",
    ),
    "do50PushUps": MessageLookupByLibrary.simpleMessage("Fazer 50 flexões"),
    "doNotForgetToCheckYourHabits": MessageLookupByLibrary.simpleMessage(
      "Não te esqueças de rever os teus hábitos.",
    ),
    "donateToCharity": MessageLookupByLibrary.simpleMessage(
      "Doar 10€ a uma instituição de caridade",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Feito"),
    "dontHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Ainda não tem conta? ",
    ),
    "editCategory": MessageLookupByLibrary.simpleMessage("Editar categoria"),
    "editHabit": MessageLookupByLibrary.simpleMessage("Editar Hábito"),
    "emailIsRequired": MessageLookupByLibrary.simpleMessage(
      "O e-mail é obrigatório",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "emailPasswordAndAccount": MessageLookupByLibrary.simpleMessage(
      "E-mail, palavra-passe e conta",
    ),
    "emptyList": MessageLookupByLibrary.simpleMessage("Lista vazia"),
    "endToEndEncryption": MessageLookupByLibrary.simpleMessage(
      "Encriptação de ponta a ponta",
    ),
    "enterAmount": MessageLookupByLibrary.simpleMessage("Adicionar quantidade"),
    "enterCurrentPasswordAndChooseNew": MessageLookupByLibrary.simpleMessage(
      "Introduza a sua palavra-passe atual e escolha uma nova.",
    ),
    "enterEmailForResetLink": MessageLookupByLibrary.simpleMessage(
      "Introduza o seu endereço de e-mail e enviaremos uma ligação para repor a sua palavra-passe.",
    ),
    "enterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Introduza um e-mail válido",
    ),
    "enterValidUrl": MessageLookupByLibrary.simpleMessage(
      "Introduza um URL válido (p. ex., https://o-seu-projeto.supabase.co)",
    ),
    "enterYourPasswordToConfirm": MessageLookupByLibrary.simpleMessage(
      "Introduza a sua palavra-passe para confirmar",
    ),
    "errorText": MessageLookupByLibrary.simpleMessage("Erro"),
    "errorWithDescription": m19,
    "everythingIsSafe": MessageLookupByLibrary.simpleMessage(
      "Está tudo em segurança",
    ),
    "exercise": MessageLookupByLibrary.simpleMessage("Exercício"),
    "fail": MessageLookupByLibrary.simpleMessage("Fracasso"),
    "failedToDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Falha ao eliminar a conta",
    ),
    "failedToDeleteCategory": m10,
    "failedToResend": m20,
    "failedToSaveCategory": m11,
    "failedToSendResetLink": MessageLookupByLibrary.simpleMessage(
      "Falha ao enviar a ligação de reposição. Por favor, tente novamente.",
    ),
    "featureArchiveDesc": MessageLookupByLibrary.simpleMessage(
      "Oculte hábitos que já não acompanha, sem os eliminar",
    ),
    "featureArchiveTitle": MessageLookupByLibrary.simpleMessage("Arquivo"),
    "featureCategoriesDesc": MessageLookupByLibrary.simpleMessage(
      "Organize hábitos com filtros de categorias",
    ),
    "featureCategoriesTitle": MessageLookupByLibrary.simpleMessage(
      "Categorias",
    ),
    "featureDeepLinksDesc": MessageLookupByLibrary.simpleMessage(
      "Abra a Habo diretamente em ecrãs como as definições ou a criação de hábitos",
    ),
    "featureDeepLinksTitle": MessageLookupByLibrary.simpleMessage(
      "Esquema de URL (ligações diretas)",
    ),
    "featureHomescreenWidgetDarkModeDesc": MessageLookupByLibrary.simpleMessage(
      "O widget para o ecrã principal do Android suporta agora fundos claros e escuros.",
    ),
    "featureHomescreenWidgetDesc": MessageLookupByLibrary.simpleMessage(
      "Veja o progresso dos seus hábitos num relance a partir do ecrã principal (experimental)",
    ),
    "featureHomescreenWidgetTitle": MessageLookupByLibrary.simpleMessage(
      "Widget do ecrã inicial",
    ),
    "featureIosSoundMixingDesc": MessageLookupByLibrary.simpleMessage(
      "Os sons da Habo já não interrompem a sua música ou podcasts",
    ),
    "featureIosSoundMixingTitle": MessageLookupByLibrary.simpleMessage(
      "Mistura de som corrigida",
    ),
    "featureIosWidgetsDesc": MessageLookupByLibrary.simpleMessage(
      "Marque um hábito, veja o progresso de hoje ou o ano inteiro de um hábito diretamente no ecrã principal. Adicione um widget por hábito.",
    ),
    "featureIosWidgetsTitle": MessageLookupByLibrary.simpleMessage(
      "Novos widgets para o ecrã principal (iOS)",
    ),
    "featureLockDesc": MessageLookupByLibrary.simpleMessage(
      "Proteja a aplicação com Face ID / Touch ID / biometria",
    ),
    "featureLockTitle": MessageLookupByLibrary.simpleMessage(
      "Bloqueio da aplicação",
    ),
    "featureLongpressCheckDesc": MessageLookupByLibrary.simpleMessage(
      "Toque longamente nos botões dos hábitos para alterar rapidamente o estado",
    ),
    "featureLongpressCheckTitle": MessageLookupByLibrary.simpleMessage(
      "Marcar com toque longo",
    ),
    "featureMaterialYouDesc": MessageLookupByLibrary.simpleMessage(
      "Cores dinâmicas que se adequam ao seu papel de parede",
    ),
    "featureMaterialYouTitle": MessageLookupByLibrary.simpleMessage(
      "Tema Material You (Android)",
    ),
    "featureNumericDesc": MessageLookupByLibrary.simpleMessage(
      "Registe contagens como copos de água ou páginas lidas",
    ),
    "featureNumericTitle": MessageLookupByLibrary.simpleMessage(
      "Valores numéricos nos hábitos",
    ),
    "featureSoundDesc": MessageLookupByLibrary.simpleMessage(
      "Volume ajustável",
    ),
    "featureSoundTitle": MessageLookupByLibrary.simpleMessage(
      "Novo motor de som",
    ),
    "fifteenMinOfVideoGames": MessageLookupByLibrary.simpleMessage(
      "15 minutos de videojogos",
    ),
    "fileNotFound": MessageLookupByLibrary.simpleMessage(
      "Ficheiro não encontrado",
    ),
    "fileTooLarge": MessageLookupByLibrary.simpleMessage(
      "Ficheiro muito grande (max 10MB)",
    ),
    "fingerprint": MessageLookupByLibrary.simpleMessage("Impressões digitais"),
    "firstDayOfWeek": MessageLookupByLibrary.simpleMessage("Início da semana"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Esqueceu-se da palavra-passe?",
    ),
    "fromPreviousBackups": MessageLookupByLibrary.simpleMessage(
      "A partir de cópias de segurança anteriores",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Começar"),
    "habit": MessageLookupByLibrary.simpleMessage("Hábito"),
    "habitArchived": MessageLookupByLibrary.simpleMessage("Hábito arquivado"),
    "habitContract": MessageLookupByLibrary.simpleMessage("Contrato de hábito"),
    "habitContractDescription": MessageLookupByLibrary.simpleMessage(
      "Embora o reforço positivo seja recomendado, algumas pessoas podem optar por um contrato de hábitos. Um contrato de hábitos permite especificar uma sanção que será imposta caso não cumpras o teu hábito e pode envolver um parceiro de responsabilidade ou alguém que te ajude a supervisionar os teus hábitos.",
    ),
    "habitDeleted": MessageLookupByLibrary.simpleMessage("Hábito eliminado."),
    "habitLoop": MessageLookupByLibrary.simpleMessage("Criação de hábitos"),
    "habitLoopDescription": MessageLookupByLibrary.simpleMessage(
      "A criação de hábitos é um modelo psicológico que descreve o processo de formação de hábitos. Consiste em três componentes: Estímulo, Rotina e Recompensa. O estímulo leva à rotina (ação habitual), que é reforçada pela recompensa, criando assim um círculo que ajuda a enraizar o hábito e a tornar provável a sua repetição.",
    ),
    "habitNotifications": MessageLookupByLibrary.simpleMessage(
      "Notificações sobre os hábitos",
    ),
    "habitNotificationsChannel": MessageLookupByLibrary.simpleMessage(
      "Formato das notificações dos hábitos",
    ),
    "habitTitleEmptyError": MessageLookupByLibrary.simpleMessage(
      "O título do hábito não pode ficar em branco.",
    ),
    "habitType": MessageLookupByLibrary.simpleMessage("Tipo de hábito"),
    "habitUnarchived": MessageLookupByLibrary.simpleMessage(
      "Hábito desarquivado",
    ),
    "habits": MessageLookupByLibrary.simpleMessage("Hábitos:"),
    "habitsCount": m21,
    "habitsToday": MessageLookupByLibrary.simpleMessage("Hábitos de hoje"),
    "habo": MessageLookupByLibrary.simpleMessage("Habo"),
    "haboCloudDefault": MessageLookupByLibrary.simpleMessage(
      "Habo Cloud (predefinido)",
    ),
    "haboNeedsPermission": MessageLookupByLibrary.simpleMessage(
      "A Habo precisa de autorização para enviar notificações para funcionar devidamente.",
    ),
    "haboSyncComingSoon": MessageLookupByLibrary.simpleMessage("Em breve"),
    "haboSyncDescription": MessageLookupByLibrary.simpleMessage(
      "O Habo Sync chegou! Sincronize e faça cópias de segurança dos seus hábitos em todos os seus dispositivos com sincronização na nuvem encriptada de ponta a ponta.",
    ),
    "haboSyncLearnMore": MessageLookupByLibrary.simpleMessage(
      "Descubra mais em habo.space/sync",
    ),
    "ifYouWantToSupport": MessageLookupByLibrary.simpleMessage(
      "Caso queiras apoiar a Habo:",
    ),
    "importantCannotBeRecovered": MessageLookupByLibrary.simpleMessage(
      "Importante: não pode ser recuperada",
    ),
    "incorrectCurrentPassword": MessageLookupByLibrary.simpleMessage(
      "Palavra-passe atual incorreta",
    ),
    "incorrectPassword": MessageLookupByLibrary.simpleMessage(
      "Palavra-passe incorreta",
    ),
    "input": MessageLookupByLibrary.simpleMessage("Entrada"),
    "invalidBackupFile": MessageLookupByLibrary.simpleMessage(
      "Ficheiro de backup inválido",
    ),
    "iris": MessageLookupByLibrary.simpleMessage("Íris"),
    "iveVerifiedMyEmail": MessageLookupByLibrary.simpleMessage(
      "Já verifiquei o meu e-mail",
    ),
    "keepHabitsSafeAndSynced": MessageLookupByLibrary.simpleMessage(
      "Mantenha os seus hábitos seguros e sincronizados em todos os seus dispositivos.",
    ),
    "lastSyncedDaysAgo": m22,
    "lastSyncedHoursAgo": m23,
    "lastSyncedJustNow": MessageLookupByLibrary.simpleMessage(
      "Sincronizado agora mesmo",
    ),
    "lastSyncedMinsAgo": m24,
    "logYourDays": MessageLookupByLibrary.simpleMessage("Regista os teus dias"),
    "manageSubscription": MessageLookupByLibrary.simpleMessage(
      "Gerir subscrição",
    ),
    "masterPasswordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Palavra-passe mestra alterada com sucesso",
    ),
    "masterPasswordDescriptionSetup": MessageLookupByLibrary.simpleMessage(
      "A sua palavra-passe mestra encripta todos os seus dados antes de saírem do dispositivo. Escolha algo forte e fácil de memorizar.",
    ),
    "masterPasswordDescriptionUnlock": MessageLookupByLibrary.simpleMessage(
      "Introduza a sua palavra-passe mestra para desencriptar os seus dados e ativar a sincronização.",
    ),
    "masterPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Palavra-passe mestra",
    ),
    "masterPasswordWarning": MessageLookupByLibrary.simpleMessage(
      "Não guardamos a sua palavra-passe. Se a esquecer, os seus dados não poderão ser recuperados. Anote-a num local seguro!",
    ),
    "minimum8Characters": MessageLookupByLibrary.simpleMessage(
      "Mínimo de 8 caracteres",
    ),
    "modify": MessageLookupByLibrary.simpleMessage("Modificar"),
    "month": MessageLookupByLibrary.simpleMessage("Mês"),
    "neverSynced": MessageLookupByLibrary.simpleMessage("Nunca sincronizado"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nova palavra-passe"),
    "newPasswordIsRequired": MessageLookupByLibrary.simpleMessage(
      "É necessária uma nova palavra-passe",
    ),
    "newPasswordMustBeDifferent": MessageLookupByLibrary.simpleMessage(
      "A nova palavra-passe tem de ser diferente da atual",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Próximo"),
    "noArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Sem hábitos arquivados",
    ),
    "noBackupsAvailable": MessageLookupByLibrary.simpleMessage(
      "Ainda não há cópias de segurança disponíveis.\nAs cópias de segurança são criadas automaticamente durante a sincronização.",
    ),
    "noCategoriesYet": MessageLookupByLibrary.simpleMessage(
      "Ainda não há categorias",
    ),
    "noDataAboutHabits": MessageLookupByLibrary.simpleMessage(
      "Não há nenhum dado sobre hábitos.",
    ),
    "noHabitsInCategory": m12,
    "noPreviousPurchasesFound": MessageLookupByLibrary.simpleMessage(
      "Não foram encontradas compras anteriores.",
    ),
    "notActive": MessageLookupByLibrary.simpleMessage("Inativo"),
    "notConfigured": MessageLookupByLibrary.simpleMessage("Não configurado"),
    "notSoSuccessful": MessageLookupByLibrary.simpleMessage(
      "Não tão bem sucedido",
    ),
    "note": MessageLookupByLibrary.simpleMessage("Nota"),
    "notificationTime": MessageLookupByLibrary.simpleMessage(
      "Horário da notificação",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notificações"),
    "numericHabit": MessageLookupByLibrary.simpleMessage("Progressivo"),
    "numericHabitDescription": MessageLookupByLibrary.simpleMessage(
      "Os hábitos numéricos permitem que acompanhe o progresso em incrementos ao longo do dia.",
    ),
    "observeYourProgress": MessageLookupByLibrary.simpleMessage(
      "Observa o teu progresso",
    ),
    "offline": MessageLookupByLibrary.simpleMessage("Offline"),
    "offlineMode": MessageLookupByLibrary.simpleMessage("Modo offline"),
    "offlineModeDescription": MessageLookupByLibrary.simpleMessage(
      "Desativar a sincronização e todas as ligações de rede",
    ),
    "offlineModeRestartContent": MessageLookupByLibrary.simpleMessage(
      "Feche e volte a abrir a aplicação para aplicar o modo offline.",
    ),
    "ohNoSanction": MessageLookupByLibrary.simpleMessage(
      "Oh não! Eis a tua sanção:",
    ),
    "ok": MessageLookupByLibrary.simpleMessage("OK"),
    "onboarding": MessageLookupByLibrary.simpleMessage("Ecrã inicial"),
    "oneTapCheck": MessageLookupByLibrary.simpleMessage("Um toque para marcar"),
    "or": MessageLookupByLibrary.simpleMessage("ou"),
    "orContinueWith": MessageLookupByLibrary.simpleMessage("ou continuar com"),
    "partialValue": MessageLookupByLibrary.simpleMessage("Valor parcial"),
    "partialValueDescription": MessageLookupByLibrary.simpleMessage(
      "Para acompanhar o progresso em incrementos menores",
    ),
    "passwordCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "A palavra-passe não pode estar vazia",
    ),
    "passwordIsRequired": MessageLookupByLibrary.simpleMessage(
      "A palavra-passe é obrigatória",
    ),
    "passwordLabel": MessageLookupByLibrary.simpleMessage("Palavra-passe"),
    "passwordMinLengthError": MessageLookupByLibrary.simpleMessage(
      "A palavra-passe deve ter pelo menos 8 caracteres",
    ),
    "passwordResetSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "A sua palavra-passe foi reposta com sucesso. Já pode iniciar sessão com a nova palavra-passe.",
    ),
    "passwordUpdated": MessageLookupByLibrary.simpleMessage(
      "Palavra-passe atualizada!",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "As palavras-passe não coincidem",
    ),
    "pauseSyncing": MessageLookupByLibrary.simpleMessage(
      "Pausar sincronização",
    ),
    "paused": MessageLookupByLibrary.simpleMessage("Em pausa"),
    "pausesSyncingAndBackup": MessageLookupByLibrary.simpleMessage(
      "Pausa a sincronização e as cópias de segurança",
    ),
    "permanentlyDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Eliminar conta permanentemente",
    ),
    "permanentlyDeleteYourAccountAndData": MessageLookupByLibrary.simpleMessage(
      "Eliminar permanentemente a sua conta e os seus dados",
    ),
    "pleaseConfirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Confirme a sua palavra-passe",
    ),
    "pleaseEnterCategoryTitle": MessageLookupByLibrary.simpleMessage(
      "Por favor, insira um título de categoria",
    ),
    "pleaseEnterValidEmail": MessageLookupByLibrary.simpleMessage(
      "Introduza um endereço de e-mail válido",
    ),
    "pleaseSignInWithEmailAndPassword": MessageLookupByLibrary.simpleMessage(
      "Inicie sessão com o seu e-mail e palavra-passe.",
    ),
    "pleaseTypeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Escreva DELETE para confirmar",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Política de Privacidade",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Perfil"),
    "progress": MessageLookupByLibrary.simpleMessage("Progresso"),
    "progressOf": m13,
    "purchasesRestoredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Compras restauradas com sucesso!",
    ),
    "realTimeSyncAcrossDevices": MessageLookupByLibrary.simpleMessage(
      "Sincronização em tempo real entre dispositivos",
    ),
    "reenableTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Reative o Touch ID ou o Face ID",
    ),
    "remainderOfReward": MessageLookupByLibrary.simpleMessage(
      "O lembrete da recompensa após uma rotina cumprida.",
    ),
    "remainderOfSanction": MessageLookupByLibrary.simpleMessage(
      "O lembrete da sanção após não cumprir uma rotina.",
    ),
    "resendInSeconds": m25,
    "resendVerificationEmail": MessageLookupByLibrary.simpleMessage(
      "Reenviar e-mail de verificação",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Restabelecer"),
    "resetAction": MessageLookupByLibrary.simpleMessage("Redefinir"),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "Repor palavra-passe",
    ),
    "resetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Introduza o seu endereço de e-mail e enviaremos uma ligação para repor a sua palavra-passe.",
    ),
    "resetToHaboCloud": MessageLookupByLibrary.simpleMessage(
      "Repor para a Habo Cloud",
    ),
    "resetToHaboCloudQuestion": MessageLookupByLibrary.simpleMessage(
      "Repor para a Habo Cloud?",
    ),
    "restEasy": MessageLookupByLibrary.simpleMessage("Sem preocupações"),
    "restEasyDesc": MessageLookupByLibrary.simpleMessage(
      "Guardamos em segurança todo o seu histórico de progresso na nuvem. Total tranquilidade, de forma automática.",
    ),
    "restartRequired": MessageLookupByLibrary.simpleMessage(
      "Reinicialização Necessária",
    ),
    "restartRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Feche e volte a abrir a aplicação para ligar ao novo servidor.",
    ),
    "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
    "restoreBackupConfirmation": m26,
    "restoreBackupQuestion": MessageLookupByLibrary.simpleMessage(
      "Restaurar cópia de segurança?",
    ),
    "restoreCompletedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Restauração concluída com sucesso!",
    ),
    "restoreData": MessageLookupByLibrary.simpleMessage("Restaurar dados"),
    "restoreFailed": MessageLookupByLibrary.simpleMessage(
      "Falha na restauração!",
    ),
    "restoreFailedError": MessageLookupByLibrary.simpleMessage(
      "Erro ao restaurar cópia de segurança.",
    ),
    "restoreFailedTryAgain": MessageLookupByLibrary.simpleMessage(
      "Falha ao restaurar. Por favor, tente novamente.",
    ),
    "restoreFailedWithError": m27,
    "restorePurchases": MessageLookupByLibrary.simpleMessage(
      "Restaurar compras",
    ),
    "reward": MessageLookupByLibrary.simpleMessage("Recompensa"),
    "rewardDescription": MessageLookupByLibrary.simpleMessage(
      "é o benefício ou sensação positiva que sentes após realizar a rotina. Reforça o hábito.",
    ),
    "rewardNumbered": MessageLookupByLibrary.simpleMessage("3. Recompensa"),
    "routine": MessageLookupByLibrary.simpleMessage("Rotina"),
    "routineDescription": MessageLookupByLibrary.simpleMessage(
      "é a ação que realizas em resposta ao estímulo. Isto é o hábito em si.",
    ),
    "routineNumbered": MessageLookupByLibrary.simpleMessage("2. Rotina"),
    "sanction": MessageLookupByLibrary.simpleMessage("Sanção"),
    "save": MessageLookupByLibrary.simpleMessage("Guardar"),
    "saveProgress": MessageLookupByLibrary.simpleMessage("Gravar progresso"),
    "seamlessContinuity": MessageLookupByLibrary.simpleMessage(
      "Continuidade perfeita",
    ),
    "seamlessContinuityDesc": MessageLookupByLibrary.simpleMessage(
      "Os seus hábitos, perfeitamente sincronizados em todo o lado. Comece a acompanhar no telemóvel e marque no tablet sem interrupções.",
    ),
    "searchIcons": MessageLookupByLibrary.simpleMessage("Pesquisar"),
    "selectCategories": MessageLookupByLibrary.simpleMessage(
      "Selecionar categorias",
    ),
    "selectIcon": MessageLookupByLibrary.simpleMessage("Escolher um ícone"),
    "selectedCategories": m14,
    "selfHostDescription": MessageLookupByLibrary.simpleMessage(
      "Aloje o seu próprio backend Supabase para ter acesso total à sincronização sem subscrição. Consulte o guia de autoalojamento para instruções de configuração.",
    ),
    "sendResetLink": MessageLookupByLibrary.simpleMessage(
      "Enviar ligação de reposição",
    ),
    "server": MessageLookupByLibrary.simpleMessage("Servidor"),
    "serverConfiguration": MessageLookupByLibrary.simpleMessage(
      "Configuração do servidor",
    ),
    "setColors": MessageLookupByLibrary.simpleMessage("Definir cores"),
    "setNewPassword": MessageLookupByLibrary.simpleMessage(
      "Definir nova palavra-passe",
    ),
    "setPassword": MessageLookupByLibrary.simpleMessage(
      "Definir palavra-passe",
    ),
    "setUpSyncToEnable": MessageLookupByLibrary.simpleMessage(
      "Configure a sincronização para ativar",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Definições"),
    "setupDeviceCredentials": MessageLookupByLibrary.simpleMessage(
      "Configure as credenciais do dispositivo nas definições",
    ),
    "setupFingerprintFaceUnlock": MessageLookupByLibrary.simpleMessage(
      "Configure a impressão digital ou o desbloqueio facial nas definições do dispositivo",
    ),
    "setupTouchIdFaceId": MessageLookupByLibrary.simpleMessage(
      "Configure o Touch ID ou o Face ID nas definições do dispositivo",
    ),
    "showCategories": MessageLookupByLibrary.simpleMessage(
      "Mostrar categorias",
    ),
    "showMonthName": MessageLookupByLibrary.simpleMessage("Mostrar o mês"),
    "showReward": MessageLookupByLibrary.simpleMessage("Mostrar recompensa"),
    "showSanction": MessageLookupByLibrary.simpleMessage("Mostrar a sanção"),
    "signIn": MessageLookupByLibrary.simpleMessage("Iniciar sessão"),
    "signInFailedPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Falha ao iniciar sessão. Por favor, tente novamente.",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Terminar sessão"),
    "signOutConfirmationContent": MessageLookupByLibrary.simpleMessage(
      "Terá de introduzir novamente a sua palavra-passe mestra para aceder aos dados sincronizados.",
    ),
    "signOutQuestion": MessageLookupByLibrary.simpleMessage("Terminar sessão?"),
    "signUp": MessageLookupByLibrary.simpleMessage("Registar"),
    "skip": MessageLookupByLibrary.simpleMessage("Saltar"),
    "skipDoesNotAffectStreaks": MessageLookupByLibrary.simpleMessage(
      "Omitir (não afeta as sequências)",
    ),
    "slider": MessageLookupByLibrary.simpleMessage("Controlo deslizante"),
    "soundEffects": MessageLookupByLibrary.simpleMessage("Sons"),
    "sourceCode": MessageLookupByLibrary.simpleMessage("Código-fonte (GitHub)"),
    "statistics": MessageLookupByLibrary.simpleMessage("Estatísticas"),
    "subscribe": MessageLookupByLibrary.simpleMessage("Subscrever"),
    "subscribeToEnableSync": MessageLookupByLibrary.simpleMessage(
      "Subscreva para ativar o Habo Sync",
    ),
    "subscriptionNeeded": MessageLookupByLibrary.simpleMessage(
      "Subscrição necessária",
    ),
    "successful": MessageLookupByLibrary.simpleMessage("Bem sucedido"),
    "syncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Sincronização e cópia de segurança",
    ),
    "syncAndBackupYourData": MessageLookupByLibrary.simpleMessage(
      "Sincronize e faça cópias de segurança dos seus dados",
    ),
    "syncError": MessageLookupByLibrary.simpleMessage("Erro de sincronização"),
    "syncNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Sincronização indisponível",
    ),
    "syncNow": MessageLookupByLibrary.simpleMessage("Sincronizar agora"),
    "syncTitle": MessageLookupByLibrary.simpleMessage("Sincronização"),
    "syncingHero": MessageLookupByLibrary.simpleMessage("A sincronizar..."),
    "syncingPaused": MessageLookupByLibrary.simpleMessage(
      "Sincronização em pausa",
    ),
    "syncingPausedDesc": MessageLookupByLibrary.simpleMessage("Pausado"),
    "syncingToCloud": MessageLookupByLibrary.simpleMessage(
      "A sincronizar com a nuvem",
    ),
    "tapCheckLongPressMenu": MessageLookupByLibrary.simpleMessage(
      "Tocar para marcar, toque longo para o menu",
    ),
    "tapSyncNowToRetry": MessageLookupByLibrary.simpleMessage(
      "Toque em «Sincronizar agora» para tentar novamente",
    ),
    "targetProgress": m15,
    "targetValue": MessageLookupByLibrary.simpleMessage("Valor alvo"),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Termos e Condições",
    ),
    "testConnectionAndSave": MessageLookupByLibrary.simpleMessage(
      "Testar ligação e guardar",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "themeSelect": m0,
    "thisChangesYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Isto altera a sua palavra-passe de início de sessão na Habo.",
    ),
    "todayAt": m28,
    "topStreak": MessageLookupByLibrary.simpleMessage("Maior sequência"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "touchSensor": MessageLookupByLibrary.simpleMessage("Toque no sensor"),
    "trackYourProgress": MessageLookupByLibrary.simpleMessage(
      "Podes acompanhar o teu progresso através do calendário de cada um dos hábitos ou na página de estatísticas.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Tente Novamente"),
    "twoDayRule": MessageLookupByLibrary.simpleMessage("Regra dos dois dias"),
    "twoDayRuleDescription": MessageLookupByLibrary.simpleMessage(
      "Com a regra dos dois dias, podes faltar um dia sem afetar a sequência, desde que cumpras o hábito no dia seguinte.",
    ),
    "typeDeleteToConfirm": MessageLookupByLibrary.simpleMessage(
      "Escreva DELETE para confirmar",
    ),
    "unableToVerifyIdentity": MessageLookupByLibrary.simpleMessage(
      "Não foi possível verificar a identidade",
    ),
    "unarchive": MessageLookupByLibrary.simpleMessage("Desarquivar"),
    "unarchiveHabit": MessageLookupByLibrary.simpleMessage(
      "Desarquivar Hábito",
    ),
    "unavailableWhileOffline": MessageLookupByLibrary.simpleMessage(
      "Indisponível em modo offline",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("Desfazer"),
    "unexpectedErrorPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
      "Ocorreu um erro inesperado. Por favor, tente novamente.",
    ),
    "unit": MessageLookupByLibrary.simpleMessage("Unidade"),
    "unknown": MessageLookupByLibrary.simpleMessage("Desconhecido"),
    "unlockAndSync": MessageLookupByLibrary.simpleMessage(
      "Desbloquear e sincronizar",
    ),
    "unlockPasswordExplanation": MessageLookupByLibrary.simpleMessage(
      "Esta é a palavra-passe que criou quando configurou a sincronização pela primeira vez noutro dispositivo.",
    ),
    "unlockSyncAndBackup": MessageLookupByLibrary.simpleMessage(
      "Desbloquear sincronização e cópia de segurança",
    ),
    "unlockYourData": MessageLookupByLibrary.simpleMessage(
      "Desbloqueie os seus dados",
    ),
    "updateYourEncryptionPassword": MessageLookupByLibrary.simpleMessage(
      "Atualizar a palavra-passe de encriptação",
    ),
    "updateYourLoginPassword": MessageLookupByLibrary.simpleMessage(
      "Atualizar a palavra-passe de início de sessão",
    ),
    "urlIsRequired": MessageLookupByLibrary.simpleMessage(
      "O URL é obrigatório",
    ),
    "urlMustStartWithHttpOrHttps": MessageLookupByLibrary.simpleMessage(
      "O URL tem de começar por https:// ou http://",
    ),
    "useTwoDayRule": MessageLookupByLibrary.simpleMessage(
      "Utilizar regra dos dois dias",
    ),
    "verificationEmailResent": MessageLookupByLibrary.simpleMessage(
      "E-mail de verificação reenviado!",
    ),
    "viewArchivedHabits": MessageLookupByLibrary.simpleMessage(
      "Visualizar hábitos arquivados",
    ),
    "viewOrCancelYourPlan": MessageLookupByLibrary.simpleMessage(
      "Ver ou cancelar o seu plano",
    ),
    "warning": MessageLookupByLibrary.simpleMessage("Aviso"),
    "weSentVerificationLinkTo": MessageLookupByLibrary.simpleMessage(
      "Enviámos uma ligação de verificação para",
    ),
    "week": MessageLookupByLibrary.simpleMessage("Semana"),
    "weekdayAt": m29,
    "welcomeBackStayConsistent": MessageLookupByLibrary.simpleMessage(
      "Bem-vindo de volta! Vamos manter a consistência.",
    ),
    "whatsNewTitle": MessageLookupByLibrary.simpleMessage("O que há de novo"),
    "whatsNewVersion": m16,
    "widgetChooseHabit": MessageLookupByLibrary.simpleMessage(
      "Escolha um hábito",
    ),
    "widgetNoHabits": MessageLookupByLibrary.simpleMessage(
      "Adicione um hábito na Habo",
    ),
    "widgetTheme": MessageLookupByLibrary.simpleMessage("Tema do widget"),
    "willSyncWhenConnected": MessageLookupByLibrary.simpleMessage(
      "Será sincronizado quando houver ligação",
    ),
    "yesterdayAt": m30,
    "youAreOffline": MessageLookupByLibrary.simpleMessage("Está offline"),
    "yourCommentHere": MessageLookupByLibrary.simpleMessage("O teu comentário"),
    "zeroKnowledgePrivacy": MessageLookupByLibrary.simpleMessage(
      "Privacidade de conhecimento zero",
    ),
    "zeroKnowledgePrivacyDesc": MessageLookupByLibrary.simpleMessage(
      "Encriptação de ponta a ponta de última geração. Só você tem a chave mestra — nunca poderemos ler nem aceder aos seus dados pessoais.",
    ),
  };
}
