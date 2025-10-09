import { Button } from "primereact/button";

export enum EButtonType {
  Submit = "submit",
  Cancel = "cancel",
}

interface IIconButtonProps {
  type: EButtonType;
  label: string;
  className?: string;
  disabled?: boolean;
}

const IconButton = ({ ...props }: IIconButtonProps) => {
  const { type, label, className, disabled } = props;
  return (
    <Button
      label={label}
      icon={type === EButtonType.Submit ? "pi pi-check" : "pi pi-times"}
      className={`px-4 py-2 ${className} ${
        type === EButtonType.Submit ? "bg-primary" : "bg-gray-500"
      }`}
      style={{ color: "white" }}
      disabled={disabled}
    />
  );
};

export default IconButton;
