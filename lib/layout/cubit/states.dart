abstract class ControlPanelStates{}
class ControlPanelInitialState extends ControlPanelStates{}

class GetOrdersLoadingState extends ControlPanelStates{}
class GetOrdersSuccessState extends ControlPanelStates{}
class GetOrdersErrorState extends ControlPanelStates{}

class GetBillDetailsLoadingState extends ControlPanelStates{}
class GetBillDetailsSuccessState extends ControlPanelStates{}
class GetBillDetailsErrorState extends ControlPanelStates{}

class GetUsersLoadingState extends ControlPanelStates{}
class GetUsersSuccessState extends ControlPanelStates{}
class GetUsersErrorState extends ControlPanelStates{}

class ChangeUserStatusSuccessState extends ControlPanelStates{}
class ChangeUserStatusErrorState extends ControlPanelStates{}

class GetAddressSuccessState extends ControlPanelStates{}
class GetAddressErrorState extends ControlPanelStates{}

class GetAddressOwnerProductSuccessState extends ControlPanelStates{}
class GetAddressOwnerProductErrorState extends ControlPanelStates{}

class InitialMapState extends ControlPanelStates{}
class ChoiceImageSuccessState extends ControlPanelStates{}
class ChoiceImageErrorState extends ControlPanelStates{}

class PhotoSuccessSuccessState extends ControlPanelStates{}
class PhotoSuccessErrorState extends ControlPanelStates{}

class AddTokenLoadingState extends ControlPanelStates{}
class AddTokenSuccessState extends ControlPanelStates{}
class AddTokenErrorState extends ControlPanelStates{}

class GetWishLoadingState extends ControlPanelStates{}
class GetWishSuccessState extends ControlPanelStates{}
class GetWishErrorState extends ControlPanelStates{}

class ChangeStatusOrderSuccessState extends ControlPanelStates{}
class ChangeStatusOrderErrorState extends ControlPanelStates{}

class ChangeStatusWishSuccessState extends ControlPanelStates{}
class ChangeStatusWishErrorState extends ControlPanelStates{}

class ChangeStatusProductLoadingState extends ControlPanelStates{}
class ChangeStatusProductSuccessState extends ControlPanelStates{}
class ChangeStatusProductErrorState extends ControlPanelStates{}
class IsDeleteState extends ControlPanelStates{}
class IsNotDeleteState extends ControlPanelStates{}

class GetProductLoadingState extends ControlPanelStates{}
class GetProductSuccessState extends ControlPanelStates{}
class GetProductErrorState extends ControlPanelStates{}

class CheckSocketState extends ControlPanelStates{}

class ConnectionErrorState extends ControlPanelStates{}
class ConnectionSuccessState extends ControlPanelStates{}
class OpenAppState extends ControlPanelStates{}

class GetPercentLoadingState extends ControlPanelStates{}
class GetPercentSuccessState extends ControlPanelStates{}
class GetPercentErrorState extends ControlPanelStates{}

class GetAllProductLoadingState extends ControlPanelStates{}
class GetAllProductSuccessState extends ControlPanelStates{}
class GetAllProductErrorState extends ControlPanelStates{}

class GetDeleteProductLoadingState extends ControlPanelStates{}
class GetDeleteProductSuccessState extends ControlPanelStates{}
class GetDeleteProductErrorState extends ControlPanelStates{}

class ChangeProductLoadingState extends ControlPanelStates{}
class ChangeProductSuccessState extends ControlPanelStates{
  final String message;
  final bool status;

  ChangeProductSuccessState({required this.message,required this.status});
}
class ChangeProductErrorState extends ControlPanelStates{}

class RemoveImageState extends ControlPanelStates{}

class ChangePercentLoadingState extends ControlPanelStates{}
class ChangePercentSuccessState extends ControlPanelStates{}
class ChangePercentErrorState extends ControlPanelStates{}