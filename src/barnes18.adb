with Ada.Text_IO; use Ada.Text_IO;

procedure Barnes18 is

   subtype Digit is Character range '0' .. '9';

   type Counters is array (Digit) of Natural range 0 .. 2;

   function Val (C : Character) return Natural is (Natural'Value ("" & C));

   --------------------
   -- Print_Solution --
   --------------------

   procedure Print_Solution (I, J : Positive) is
      Spaces : Natural := 0;
   begin
      Put_Line ("  " & I'Img);
      Put_Line ("  " & J'Img);
      Put_Line ("------");
      for C of J'Img loop
         if C in Digit then
            for W in 1 .. Spaces loop
               Put (" ");
            end loop;
            Put_Line (Natural'Image (I * Val (C)));
            Spaces := Spaces + 1;
         end if;
      end loop;
      Put_Line ("------");
      Put_Line (Natural'Image (I * J));
   end Print_Solution;

   -----------
   -- Check --
   -----------

   procedure Check (I, J : Positive) is

      Counter : Counters := (others => 0);

      --------------
      -- Register --
      --------------

      procedure Register (Num : Positive) is
      begin
         for C of Num'Img loop
            if C in Digit then
               Counter (C) := Counter (C) + 1;
               --  Will raise on >2, discarding candidates
            end if;
         end loop;
      end Register;

   begin
      Register (I);
      Register (J);
      Register (I * J);

      for C of J'Img loop
         if C in Digit then
            Register (I * Val (C));
         end if;
      end loop;

      --  Verify each digit appears exactly two times:
      for V of Counter loop
         if V /= 2 then
            raise Constraint_Error;
         end if;
      end loop;

      Print_Solution (I, J);
   exception
      when Constraint_Error =>
--           Put (".");
         null;
   end Check;

begin
   for I in 100 .. 999 loop
      for J in 100 .. 999 loop
         Check (I, J);
      end loop;
   end loop;
   --  Indeed there's only one solution, although we continue checking after found
end Barnes18;
