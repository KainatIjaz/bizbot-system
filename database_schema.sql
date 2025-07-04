PGDMP  ,    *                }            Bizbot    17rc1    17rc1 1    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    24579    Bizbot    DATABASE     �   CREATE DATABASE "Bizbot" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "Bizbot";
                     postgres    false            �            1259    24920    Payment_method    TABLE     m   CREATE TABLE public."Payment_method" (
    "Payment" character varying,
    "Payment id" double precision
);
 $   DROP TABLE public."Payment_method";
       public         heap r       postgres    false            �            1259    24711    branch    TABLE     -  CREATE TABLE public.branch (
    branch_id character varying(255) NOT NULL,
    branch_name character varying(255),
    location character varying(255),
    phone_number character varying(20),
    manager_name character varying(255),
    sale character varying,
    branch_timing character varying
);
    DROP TABLE public.branch;
       public         heap r       postgres    false            �            1259    25225 
   complaints    TABLE     �   CREATE TABLE public.complaints (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    complaint_text text NOT NULL,
    submission_timestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.complaints;
       public         heap r       postgres    false            �            1259    25224    complaints_id_seq    SEQUENCE     �   CREATE SEQUENCE public.complaints_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.complaints_id_seq;
       public               postgres    false    229            �           0    0    complaints_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.complaints_id_seq OWNED BY public.complaints.id;
          public               postgres    false    228            �            1259    24829    customer    TABLE     �   CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    customer_name character varying(255),
    email character varying(255),
    phone character varying(20),
    customer_type character varying(20),
    gender character varying(20)
);
    DROP TABLE public.customer;
       public         heap r       postgres    false            �            1259    24828    customer_customer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.customer_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.customer_customer_id_seq;
       public               postgres    false    219            �           0    0    customer_customer_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.customer_customer_id_seq OWNED BY public.customer.customer_id;
          public               postgres    false    218            �            1259    25196 	   inventory    TABLE     �   CREATE TABLE public.inventory (
    inventory_id integer NOT NULL,
    product_id integer,
    branch_id character varying(255),
    quantity integer,
    last_updated interval,
    product_location character varying
);
    DROP TABLE public.inventory;
       public         heap r       postgres    false            �            1259    25195    inventory_inventory_id_seq    SEQUENCE     �   CREATE SEQUENCE public.inventory_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.inventory_inventory_id_seq;
       public               postgres    false    225            �           0    0    inventory_inventory_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.inventory_inventory_id_seq OWNED BY public.inventory.inventory_id;
          public               postgres    false    224            �            1259    25186    product    TABLE     �   CREATE TABLE public.product (
    product_id integer NOT NULL,
    category character varying(100),
    price numeric(10,2),
    description text,
    product_name character varying(255)
);
    DROP TABLE public.product;
       public         heap r       postgres    false            �            1259    25185    product_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.product_product_id_seq;
       public               postgres    false    223            �           0    0    product_product_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product.product_id;
          public               postgres    false    222            �            1259    25213    restock_notifications    TABLE       CREATE TABLE public.restock_notifications (
    id integer NOT NULL,
    product_name character varying(255),
    email character varying(255),
    whatsapp character varying(20),
    requested_quantity integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 )   DROP TABLE public.restock_notifications;
       public         heap r       postgres    false            �            1259    25212    restock_notifications_id_seq    SEQUENCE     �   CREATE SEQUENCE public.restock_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.restock_notifications_id_seq;
       public               postgres    false    227                        0    0    restock_notifications_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.restock_notifications_id_seq OWNED BY public.restock_notifications.id;
          public               postgres    false    226            �            1259    24931    sales    TABLE     :  CREATE TABLE public.sales (
    "Date" date,
    "Time" character varying,
    sale_id integer,
    customer_id integer,
    "Branch ID" character varying,
    "Payment id" double precision,
    "Invoice ID" character varying,
    "Product ID" integer,
    "Quantity" integer,
    "Sale Price" double precision
);
    DROP TABLE public.sales;
       public         heap r       postgres    false            F           2604    25228    complaints id    DEFAULT     n   ALTER TABLE ONLY public.complaints ALTER COLUMN id SET DEFAULT nextval('public.complaints_id_seq'::regclass);
 <   ALTER TABLE public.complaints ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    229    228    229            A           2604    24832    customer customer_id    DEFAULT     |   ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);
 C   ALTER TABLE public.customer ALTER COLUMN customer_id DROP DEFAULT;
       public               postgres    false    218    219    219            C           2604    25199    inventory inventory_id    DEFAULT     �   ALTER TABLE ONLY public.inventory ALTER COLUMN inventory_id SET DEFAULT nextval('public.inventory_inventory_id_seq'::regclass);
 E   ALTER TABLE public.inventory ALTER COLUMN inventory_id DROP DEFAULT;
       public               postgres    false    224    225    225            B           2604    25189    product product_id    DEFAULT     x   ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_product_id_seq'::regclass);
 A   ALTER TABLE public.product ALTER COLUMN product_id DROP DEFAULT;
       public               postgres    false    222    223    223            D           2604    25216    restock_notifications id    DEFAULT     �   ALTER TABLE ONLY public.restock_notifications ALTER COLUMN id SET DEFAULT nextval('public.restock_notifications_id_seq'::regclass);
 G   ALTER TABLE public.restock_notifications ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    227    226    227            �          0    24920    Payment_method 
   TABLE DATA           C   COPY public."Payment_method" ("Payment", "Payment id") FROM stdin;
    public               postgres    false    220   K;       �          0    24711    branch 
   TABLE DATA           s   COPY public.branch (branch_id, branch_name, location, phone_number, manager_name, sale, branch_timing) FROM stdin;
    public               postgres    false    217   �;       �          0    25225 
   complaints 
   TABLE DATA           U   COPY public.complaints (id, email, complaint_text, submission_timestamp) FROM stdin;
    public               postgres    false    229   n<       �          0    24829    customer 
   TABLE DATA           c   COPY public.customer (customer_id, customer_name, email, phone, customer_type, gender) FROM stdin;
    public               postgres    false    219   W=       �          0    25196 	   inventory 
   TABLE DATA           r   COPY public.inventory (inventory_id, product_id, branch_id, quantity, last_updated, product_location) FROM stdin;
    public               postgres    false    225   D       �          0    25186    product 
   TABLE DATA           Y   COPY public.product (product_id, category, price, description, product_name) FROM stdin;
    public               postgres    false    223   X`       �          0    25213    restock_notifications 
   TABLE DATA           r   COPY public.restock_notifications (id, product_name, email, whatsapp, requested_quantity, created_at) FROM stdin;
    public               postgres    false    227   ��       �          0    24931    sales 
   TABLE DATA           �   COPY public.sales ("Date", "Time", sale_id, customer_id, "Branch ID", "Payment id", "Invoice ID", "Product ID", "Quantity", "Sale Price") FROM stdin;
    public               postgres    false    221   �                  0    0    complaints_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.complaints_id_seq', 7, true);
          public               postgres    false    228                       0    0    customer_customer_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.customer_customer_id_seq', 1, false);
          public               postgres    false    218                       0    0    inventory_inventory_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.inventory_inventory_id_seq', 1, false);
          public               postgres    false    224                       0    0    product_product_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.product_product_id_seq', 2, true);
          public               postgres    false    222                       0    0    restock_notifications_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.restock_notifications_id_seq', 11, true);
          public               postgres    false    226            I           2606    24717    branch branch_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (branch_id);
 <   ALTER TABLE ONLY public.branch DROP CONSTRAINT branch_pkey;
       public                 postgres    false    217            U           2606    25233    complaints complaints_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.complaints
    ADD CONSTRAINT complaints_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.complaints DROP CONSTRAINT complaints_pkey;
       public                 postgres    false    229            K           2606    24838    customer customer_email_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_email_key UNIQUE (email);
 E   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_email_key;
       public                 postgres    false    219            M           2606    24836    customer customer_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);
 @   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
       public                 postgres    false    219            Q           2606    25201    inventory inventory_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);
 B   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_pkey;
       public                 postgres    false    225            O           2606    25193    product product_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public                 postgres    false    223            S           2606    25221 0   restock_notifications restock_notifications_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.restock_notifications
    ADD CONSTRAINT restock_notifications_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.restock_notifications DROP CONSTRAINT restock_notifications_pkey;
       public                 postgres    false    227            V           2606    25207 "   inventory inventory_branch_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branch(branch_id);
 L   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_branch_id_fkey;
       public               postgres    false    225    4681    217            W           2606    25202 #   inventory inventory_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id);
 M   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_product_id_fkey;
       public               postgres    false    223    225    4687            �   ,   x�sN,��4�r.JM�,QHN,J�4�r-O��I-�4����� ��	�      �   �   x�}�AK�@Fϛ_�]�
i�4��$����i�����vj��-
& ����=�P�`I�	��R���ýA�{K_�#����1����5��c<�bN��Wک�^..�]���ZՒ��N-�*o�1x!o���{@����JU���Q��I�������B�C�6����JlG�dKzn��Ikx�!q�_� O�3U<� �Zo3=z�6���5�z       �   �   x�]N9��0�ۯ�Ƣ�mX�	I������`�AUIIu�dwtH��-�er9O����p��%�u��.��+�awy��*2���PKdkZK��� ���N�a�CX}�%����Y�aˬ�$���Q��f,�"nڷF�(��M�.=��-�}^�<�~�)��>Ե���ʴ'��a^c�0�t�!ZԊ��E��� >��'��-�ʰ6��B�ONU&      �   �  x���Mo7���_�{C�>(ޚi��V�2I6�E��덁ƿ�\J��4�5���ȗ�������a�e����z�y��x�w���|:?1��d�X������0�~s���v|��}����%��3D������1��?].�m:/���S�;��m;��orXFZ2�]�5R��oz����,y_�w�؇�f�m��=.�#����4����l�7F=�dրs�o���������{|��
�y'�M?�R�a=wADcc�z!���x��@����P %�	�ˣ���P� 8���)�_���HפAt� �d&�g2H�YFj� �[�1���ykmlQ���uȤ�@#�wB��6����s�InB�@�&#z� ���vAޏ��17����k-����@�����J�3m2��pU6ů+�ρ-֍r��jB�E�Πu�C̠�i�t%���9�\y���U�t:�c���"�/�|z��VRzN�V^Gc�J�����%�F"�m6� �͏SY\tG�!���P�h�ʌ��E`����S��
#��f�qA�UH7�̒�z�X3|��X��N��lx6��	�u���e.*��b�)�����	�2���W�	�jh�� =LX<�K�I	��v�`�k[��	PtPDW��hl�R"ORч�K���� d&�`l@�$�kƬu/��ָ:�qF��c]Z��<O�gHw��'�X����93ÒN��G�ڋ�`�&TW�k���8�ayTM�ް��A6�9;�qU��:�FE��9�A�`�J�;W�����Rli�<��!�!m.B���ҟ2��\};4�j)$I����俅�1����_E����BN�,�2zrJS=L;g��O�)^��S�:��H�"�[.���n*	d�q�n�B[�Ư�D[�FM�M�I��m'�IM�?�K�E�����)�	��^	��;dG�����8͵�?עw�-���SȍL�k7R�� ���\*[�U�^�_V�{A�>N�ӍT�;o�8�X�x�$H)"et�(Ȣ�>��1@�h)���
@<8�O�)8�F����RF���o��w�\c `3ł�X�: ���j�|^_�ʝR`�=׻���Gċe��Q�7ƴ��U�b����i�SD�y��uW3�Bl�4����� ��r�;��zt|�����GwAc�@�+ (�[�rn|
bǣo?HԼ')�{e| �v���P�Q���b�Q���\�����_R<��Q;	�O�yK�)l2-�&H�d��2P�-���&>��=����r�ph1Ҟq�T����m��Π�Ӟq���*IW�v.ʠTH�4��~@|u�6Rx�4���(C!D�/��§=�|k� c��c���:$N�)?�f���P[�jrҧל��/�����gXqҧW�4{i-2��z���3��6a�5Xҕ�g7��Fk�,>�����mC��Z���3$��[�H�A6�Fl�?L�_1��߾_�qr����s���bL᳟=���(K�����M�bI�ݻc��j3�.�ϖ�x��qT�ȃO�lI���NĈ���'�a6����]�daʀ�.����m$XS�N�P9��mG)�AZp��1'L�*��OzW���g�~������2t��H�0u������ya"�      �      x���ˎ,�qEǼ_q?@��gi�$��G��S�2 @����������M��թ�ʕ�dl�bO8��bL���/��_�ϟ��o���?��{���������o�?��?������o�����x��������w���׻x���ϯ ��ݫo���g��;������S���s�����G��!}}-�}�?����~�|��_=����W���D9*�����g?�l4���4�7���:�?4�O8?��[8��pU�����y�pE�\�<��ϸ���S��Uy��#�q^g�*θ:�?4�+\���<�4�;\��g5|~h^O����t�r��=h^�pU�i��ü����>{����XF��ð�S�˛�9���>�]Y�d ����V���)_�0�՛;��we/r��y?�~&��aX�o���|	��,�b|W���t��Wx��<�P;�'��]h�`>)<i2����1�\Y���
�"'�a�\�i�Y�(�s���<V����̃�y��_���|�^fWga��~����l�|cx+��������Y�����o��!�BK�=�{Nn���{���L[0�;��j���|���L9S���Z��a�~«,wP�A�������wGC�§�|��$���o>m\����>�"�����+|��d�hX����^e�a~��ёIΪhhʱ���Q��)��O���zw��6\_u��S+��+���L&,���B}�k��Z�w}�{����P_�μ:�g��+�W���s���ŧC�m�H��X�����]o>���	���8
�X/O��7
�X�ޫ�?�JIV_�u³�W������_��5�	X�R���w;Kw��伾��i�8
����������u����g'��$��;��� N8� &��V1Q&����)cb©N�*i��e}񙡩eb��>VU����o�|�U��&��*޽z�����OS��$tS�ˮV�����=t"�U�D��W�m�uzX_�f���8ܚy�N�5��,`���w�m��+[}՟�:F��gQ�$v�&���D$J���C�:.w�ʧPn�RdwBY>7�:G^�v��Z�2��YʧPn�Re�C�<[n�d]�LdcK�XA˧�1�C���ƚ2-���X����Ll�l�׎4=�sn �S3"jZ�/A��&v]�UP��F���v��x	��p�A��-sZ&��%�5uzV�?��*��)>�����=���e �jl�Ӳ���D�-}b��-��L�b˟�"�x�{:�&��[�VJ,ת�R�e]<�ʄ;��^}��W.���i����mY�2a�x��gv##x�kǖG������u$�@��&v��@��I�{7,��R��Y��XJl��:�脥"��M��5ۉ-��wJ�X�FQ*v �a���E�C~��Tl��@�KCl9�VL�R�?AU|r��؍�0~�q���!��+�[Zun�K�����v��)��R[b��[-��eV��|_��R+v	������r�e1?�o�Y��w���
�]��o3�ʅ0���٫�?�3[�#p?���;p�-�Z&��\E�fX�ڼ��\-��ni���3Qs����t?B�Y���t�gƖd�:���]Ͳ�QJ�[��R˲���M_1$��Xih�&�GR���4�?p���k�?p�?p��a+}��u��a�r�]��!i��:�w��'�f-�3>���u����?!�4�]E#�p�Qo�[#8EA�Ҭ�\�@�4k����8I�f-��8
��f�9�����S��a��+ם�,kg%>�QI�e-��8
�8]Z0eR���YlJo��$�=�0��k�JJI k���#��p�Bxu�:b��g�E7BX���Ҭe]�	��3�4�M	�$���)��ܧS�����$�[��l��|��mq�2�|�q�@�r��1-�_)fS����"��k��Y��a��Z��V��R3i��n�!�[��.���!|5�Z�e��I����|aͲ�A|
bͲش� >q˲�u� ,`�FY;ER��v:��h[$�S�$�^-�w§>��,[#%9�S����H',��Ԓ,V1�
)�X�X�dJ�$�Q�$k��1 ˭=�$k[t���mAV]�|	`$Y;�6I.U�%Y����-�Z���ƩY�(!|/�9ֲ���[��c�9,�`j1ֲ��|�.���y��"�k�l0��0I�c���$����T[AV���E�_�'�vB�$7�Ԃ�e�8�
��=U;m8���c}�q�\S˱،��Z��]���LLR˱�׫���-�Z��\֒�X�2��}���X�zE��G�j���-���B,�Ij�G���u���a��FR$�T8i�[�E�T�I3���_�~�U� ,S��W[m:I�2��Xl�[�r_Ib-W�a���XqKu���R�e� ,%�kٳ�	�B��X�^�
`M����0Lڀ��u_���g��D�~�o˱���U��MQ,`�:'��b�PX���$k+��`M�X�,!,��Ԓ,VwZ�r!Iڒ��Z��Gt��:�0nY��>�Rr�(ky�v�G��
���oIG��ۗ�ͩ������CNʳ���^L�t�%��f�[_w��ۗ���?�	O;,;�����W޽,Ժ5"��G��.	�(:j֗�}ك2p�&���ـ%<kV�M�Y{�*P6X	�ځU����Y��*P֭Hx��+��߁��Ft�����mg���t����R�=�k��*V6S XkXU��|�PmQU=�;A�Q��Fuo�֜�R�j�:jLU�.[�՚R5�[9G�U6� TkHU�.��fT�V~q���.w���C��ꈳ띭~�#��R]V���!��c2�l�s���hߝ��j+D�e��9��v���n���9�f�e�ٺ�Pm/�i��{��2��l�s����xd��Cս�F��{�Y)�\����ޒ�U�=��;X����epU}o2�,X�2�#`��˭!k�*|9,}�V���v���7�%�j�eneZ���e�`OȪ�W��X5��U��U��;�;Xu��ipU�/���:Vu�&�V�Um�\�����eޏgk�C���SS�j����Q���e�f�\U�˼���7�j}�:oʛC�>~(mqs�ח�2�͡^_vJ��U;��`Rڨ�7�I�*�ejaY�j����v_v
�U���;	V�&�2�U���aWU�2_��`��˛¡�_vT��U%��L�`U�/�nU�U5?�,\��ˁ�^-V�r�������PZ���eڂ@���ǋ
Ue��4����y�����_�&#%��ic�T����$H��ҟ���U���]8R���h��jN�0����Dc�����:�],T������_�)�%{B�˛Z�	�/�;	�����y�Q��ޟc�-���֣��=���K��{���ͭ���r��A�/��TB�_l� ����0̿LED���X���&�Z�_晲�/6$����f�m ���׍C�/�?wDv���z�r ���k��>'����0���wv1��	�/7qh��9a��;��~N�N23 ��ˎ��C���b�:��M����E.1ܿ�^
��&&� �������0̿L{�`�yoC��_nf�axy�H�C���J� �������v�x�����,`X��Kc ���ۥq�0����;	bx9,%����dV@C��5�E�/�{�aX��GC����ҟ�3t���2�m�u�	���Lat���ٝ-�N(�]����7���_�[�?a�e�-n��Ɵ��A�_��+��o2�ta��x�Ѕ�k�AƟS%��)�
<O�p!�9�À�/�U���������kpB��ξ./t��M�.l������9��.\?�NF�B���Ȗ.L�܊��0�2��-_�~yw��_vv����MD���-?w°��>���_�����`���H��&a�����e��"	�_v���a�����TIP�2o�%U��L��	c8N����������_v���_�#���9�T'�/�V2�_v�=�w���q�l�ҟWƏ-<a���a� 7  ���B>�?��_^o�r��W�o7�� �eGY�yB��ml��/X���B���M.����;�dx�UU��$�����o��J�����l�tA���-A;c�����I̿���J�?�:��7Y�3���or��J����]�0�?�D ��˭�� �or�"�!�e�Y�%�/�)�a���%�o7κ`�9�=0̿ɝ� ����� �o��0���Sk'�o;츠�9yb'�o��OC��L�,a���$���eǫꈡ�M�\	b�N�8��s{�P��79�����ݵqA����:a����p���0Կ�7�5��/S{הLԿ�ސa������m�t���$ބ/̿I<h���S-��S��m����J�����Z�0�&�P��_v6;���9	� ��9�0Կ��; C�����J�P������7��	`�|A���7���p�2u�-_�^@8 ��ˎ������5%�ܿ�4��J�����0t�&� R,��������&C�K�����bg�oR��b	��d��b	��W����2mZ������.&�1�?���#���SlB�_^o�����ڄ/�?ޘn�������_""t!�eg˖A�_4�t!�y�)/�?��;^�������AY�P�r[y���o2+����9��/1Q�/�M�,߻�e-�����+Ό>�Ϯ�_qvH<ƇW���9S�M�+Φ�9&M�+N�ޟc�Ŀ�~�x�I���Mc�I3�
��lQt��W������4���=��V���)���_Y����y(HG��_�9#a���S;Su�
��	Uu�
���uy[
��^��޲]A|;1�d���;wm���:�Q;˰u�����t�os��`��{T������w[�ۘ������鐙l�j ��~Έ��%u0�f�����n�Zel�tg�e���֛��붬��֌!��׫��ƌ{�mj�����,Y��?4Ւ���KS-��vw�Z�Σ3~�H&�s	v\Ud�A�������}�SY��Q�;�n�M���B��f�N�N�B@�c��!:@�c�v�Vhn,�ח� ͌uv�w�6~��p�1��T���1��T6}oAe�qh����L�9����h�B�P��-2��QThO��C�0*��0d��8�|��H*�o9��X�~� ���l��t�`*{�[���K�él>Q��U����#��Vsy�U6/��U6/�N����޷`�6/4���[e��;�	X����-Y�͋Ә6Ȫm^�g�u�j�g"8Ъn^�Ʈ�Vus�����g��Vu�ndU7/k�r�Uۼ8{;�j��ȂUټ����U]�]�sF�k^��(���yq{:V��y)J��l�d����e�йAUe�������?���jn���:��XU6/t��Nknu�m�7�[U��ā�<@���e��NUU��؝[]����[]�����k^ֻO���g�����4�w4UM�BW�T5���6�PU4w>|0U��9��C��f>���O�U=��;S�̋�<�UE����PUѼ��UE�«U�UM�B�x�UM���hpUѼЍp-W����`UѼ8OM�X�4/|G�UM����[Ms'�X�4/Φ�����$�r�4w�ՎUE��l�;��h^�&c�5�'w3R�jί5��Qռ�-�l���5��Ƴ��{?7������R�|U��<Ȳ}���ae�>0�ߊ��}��;'=��i>�|X�T��U���i^����y	�m�~yV����nE��4�\�-_��������eY�P��z�����R��a�{ת��7$;a��^&3�5��b��?���=d�ͬ�lΉ���k>9B��y���u#�@ռ���Ts�@i����Sv�0�'�-��orf���� |a���S�;_��ۑ�Ӽ��Y�P�w��9�0Ts��0�K`����	_�����i^��X/D��4&v���Ė��g���.4�B%(B�yq=;^h�)�;|����<��4&��˺qp �hΧ϶*z ����TE<�I�mˢ��7��a��E[=0��z�����s_��^����4/���0�'a�����Nl3�B5�`����� �k^��0ds�� �|RSY°�����m^6��@7/�����u'`��
��m^���N�yq5�7��bX��'� 1�����q�=�!�O��0�s/��!�O�N	c�;�R�p>ŶR�p^x�&�� �j�J	�9�F�J	�y�{`�B	��W���ͽ�C7�wUR'�6��� ��+��P��)�;_��e�_��ټ��5���5w���ל�WY�p�'��yY����5���Z�/\s^�X�/T��e���j����Ӝ/FZ�/Ls�t8�ǫh^���5>^=�M�/4�ެ~4�2/뽗���*���K��"�P�WWl��B1�&:](�^�6��1�L�L��B2/|�[&���'��)�^H態%�������C2��&cH�eݡ7C2�-�_H�|-��c>IZ	a8�N
��1/|?@�yY�+w�P̝Pg��b��/s>�&ta�s�Ѕa�/(�.��4�v�̽�8�B0��/s~9't��6޼��˺1t��_�r��ˋ�J: �//twi~9?�m��B/�� S"���Km�٨�^���Zt���匍
�_^��ᗗݍ^^����z��`^��Gm���0�1["�P��n��ܫ:;c(�N�2C1/t����e� �b����B1w:a�>���`>)�`�>\���a��F	^漠�t�{�����KQ:_��`��yY낝/s^��̝��`>�A���z������h1 �0��,�	��d��"	�9���"	���l1 C0w��~y�mY�o�/�r/����s¤N�]�f"��]�۪�B/�B�A~9�-a����BC0w�K:a�K� �`Χe0s��d��_^Z�����3��/wB��~9_Z't��Oֲ-^���b��`>i��|a������:v����Z����_^�C+-����o����`�      �      x��}�v9��Z�y7]��s�)�rٲԢl�}�݀I��R�$�o���/�� 䈔T���tW��2�����d��E���D;Y��X��;��LΖy�?�2�OY��/Y�TE(헨<��!*l���*J�����œ����m���]�۹�(���8��8{�c��QX�W8��܉wv-�C���eʢ��Hg��7EZ>Kyd:�䩰�|/��ܶ��V9Q�����YD1}���ȣ�*��h�0�HD^ڟ� ����,��K�,s���ԧ�����la����'zh+�(�i�͊Y�aa��Na�X��G��dXҺl��do�	��P�I=��R\)��;H���Kk�y!���`I�*'x�H��R�2�3��e&
~��K��DsÃyT�O(R>]����{�aI3 1s1�d2Gb.�[;����s�/�n����C0�e�Qf���
Q���4a�=i��F�#��M����#�Z�( ja�,/��c�+3b�,Ӳ�;��~w���I�(��LO��m���.�"�/|W!�7N���w��d?���O˝N�tM�X��0ˏY.J�_q<�?C8>���r/r`�f5%��f�p�����qp^�~o_�,+��;�4�w�9��A�p��=���
c�-{�ex���MSEӫ�M�Q�K��g���z��f)�^h����v��n'�(��a8iI��@n�,B���q[���3Q5u�J+�I̐�C�s ,��]�8����ѳ��(�R#Ԧ�h7a�d^fq�w��])����̡��ˣ�ex�t �2��쭅f��� r$,Ƿ4^Y��<o��` !0rp� \�����o��@z�!ش�H�����,3v,�q��E+���PM���/$���P$i:�67g,<D�Opog�$���,�ao�]�l_�S_�2z�
��q8�43�����h�^����[���,��S���|��oh�t���<���}�4���a}{��8�&'K���}�T��"��W��5=��xr�M�VD��|�ï �d�<w��8�`�$��z�G�� _�1��U$h�%�������62A�*Og���<H����-�0mQ�yV��>��3gp����#��(�e����(�;x,�[\i��[dq{)@�+��G��h���N����~�"EiQ�2�I��B`G8�m�J2�F�Bȓ�~S���K�)C ��������|״|�����׆��0G�#Q����#9X1�a>�\�g��M�[0c�Q 	8�#���� '��a8��|��:��ϻjbA��ve{���b�ˋ���p���u�<'�*���� ��E�xt	�Z�q�S�H���H�����H�;�~V�x�'�X��Q�_�N<`�%P����/���"D֢W�Z���Rm�
xf�,a�L��.f,�bP�
6 ru2��А��W�^�H�5�w���O�G������(W ��w��.��eZ,ǛL|$�a��y�y�������k�.�����U)����0K@#�	�	�&�L�-�d���Z�K� g�k �h���}����cq2/K!�7��}�<�pK�����AbCoC-�48{�sX �b�B2�:֐�:�t4��HpZ#?�2�T"��>K��U���T$
7�&H���P�<ƢDn������G���Z��ɳ�b�=�[�n�D�����YJX��:P�h}��&Q�wDaʻO|��{�>X�`�O`͜1:�.���QD� Ɵ��o�~6Ug�G���`X�_
�bPdXz��"��,Y�?DN7 ��4�f�f��NgD�Pl��C��A�C��`�������@�h�W�p��k+m )�]P�M�Cp�E�,���O`�\��4�5��h�I�i�^��p@_@��ڠ�7*w;�di��.ׇ�Qc
HQ(<f��������G'��@g%"<�&E��f�g	 ~���͆�p!��^R�>F���50Y!�Y0�vo��u���8f%	�Β�4�3KІ���=�5�;����������׼�+=�sTZ��es�/v�-�$��O�#p������34#�b$�z�?���YB��=�f�ѣ����� @WZ0�@�nu�L!��I�xF`G��P�����˶�b�J�}���p�5Gbϝ��v_�Lڡ% �iwW��������� ���(�j�CJ)N"�О�GI뽎�Ȋk5�#�a�c��.kn���M��������cw��
N�T����N{����C�Lz�5�$P�t��ThI�3��#X����'�(xy��鑭D���<P(eƫUm#0R.�>_�]�4�
�����:�gG��ί#q�����:/�s�9��?����&�Y�=�Hr��zm˦`&����r����AMc�G���s{�4�2;�:4�1�U�:���ڂ8������8�YRf���?]ӧ�|�sZ�<����R�xu6�ׅ�	� ��-��ë=�O`f�8һ��(�{�l��b�E��;.��	E��1�-$ ȑ� }:�'A����|�`�5o�$2'ͫȪ�6=��N�V��!����o���̶
]o����YƠ,f0�+�_5�o���|�g3��r/ �h��[��#
�R���3 t�@�F~/���w�kk>
�ƺS�9ɆDM�6�:�����(��m�����X���/4�'���@� �'��,m[)��a>q��;-S6��[�R��A�|؝��/��ɺ�V�[0.�ײ���֢�Y�Qz�b�{}�F�N�k ��0�8!='$�!�)8�/�>f ���4�g��Y��(�/��O��}��P�G"��/�i���H�6�`�R�h����W�q�e�凟G�.�R�7d�,��XJY9�	�b�	�mw�`�ʌ��@��^Eœ}�c��Z�Q\�*8A�Ż��M|�%@&��7��q���di�����ܷ��?+	�����b\W���~�Ѿ��!�V(Z��Ĳm�Z�/p=�J�d��7�����/��(�{��t���Q�~uG'��VJ�:�2��o����IZ���h��>Q�x��9��Ӓ�b��\k��W��������ݴ��t��ޡ�+�!��p�F{�Ϝ���>C�����ڤ����^=��.Faz�f�#�Z�o,��J�	e��W
D���k�3��@��Z��R��<�r&������ȥ@^)ѵˁξ�����{���x�Y�>��,ǔ����`��"Q�=n�%|Fg�����2b(�J��ۻ��CӘ&���%�dL�X8~/�I� �ɤ1QRD�07��./*��-�I��2��D S��!q�6��Om�������e��K8Sq1vI��8�L	���e�2����-�&lR���&t5(�;���P��x��|�q����f�Z�$��|��տnh�q>���@���L���yRP_�a*�B)9�0bl�j����å�RC!p��ƕ������J���G���$�_�2��D����Sm�J�� ��4g23��H���p��I�8��ٲ�ѵ�tV�Kd���ػ\�i��E����?
�?pO�g@��DH�� ���F�ab�gq0<�� ld?��
uW�<��e'�
V]0�/����%@�V��u-�4
��B1׎0�l�L�VC�?- >s�+D��'[�����4�8 ~}�i?����ts\�آ�9�?��+a9�Ĵ4ӹg:��e+�<�̣�sħ�IČAGy<���ue0�����O��Sk~
(3J���;���VJ)z��Z��H��Q_ ���YU��̊XX\�@ ������j�t���6�t␶�Y؈�	u��Q�:�W��懖�Pc������ӽ�t�'�bT�:��[��o!�,ϲ��h��'�����Np�1��t�KrŐ�@���ANAw�3�����} jnaV��VÀ#��T�ȍ��T���Z0��#5��c��	$)J[`���r��<� ���    ryk�o�<Z�h4=2��8�'0�c#�*k�x8I�h�np8PdDc�g��@�P�ͿZ�3�γ�(
¯è@�?႒�JPz"��QF|�:�b "�8+)��@	>J�3�*eO�"��b-J����f/��!s�J�%���� X�={0,��:�n 9)���X	Mo�^�:"͙�Ae+���t
�~�Á*#4jw���B�¤y1�3�F�('�Y?ho��Զ�ո{�h �C����A1J�k����\��6K�i�
̈��2�
�Jx��%Ͳ�Y�&#X;s�kk�:�'�Xkp�g�Ԗ$�h!�^Ub_Ex��fO}���ꚱ{:�m�9�M;jQ��;	��;�8��5>�Y��4e\��A��f�y:Y�G��+�-E:��<3��o�&�U��-=���gי�|E���1�4oӗ�:`��+K0�Z��N�	$�
��^�Wz ������F���9'��d��c�cT~�H��F@�.8Ŷ�P�I����h(���0:�	6��}���;��0��^�d� ��^��Ӑ�,EAy?_"�$?�*�=��Z~���f\_�{�����%ڟ;�������b����9��g�t��j"8�L��#�ND�>$��s{�C�j�~|�n���3L����-���IV��̱��s�铲^W81;@��RM�bs��(�	I��I�7[��K����o�q2"=#F&�{@�d-u������E�,�}�7c�3���V,�eFV���m��4���4���U~^0��Z�A!��J��o=q �s�rm,�S�z#깳��}T�Ĩ�E!�=ɧ���%J������Qn�,zg�O	��]�7G?C8�Q�)��.�?�@B߈o3��z��r�߅���_��96��\���v	O!f�����ʨ(@��r��W��"��nW؏�/�Q+��}��h�F��Z%0<=Wj�QՏ�P�.#��&�0o����v6��0<��z��Md~^m�Tכ������l�U^�O٘�4�B9Z�tv�R`�ҭ��(�oFV�s'Mf{p�&+�؈�/��&k[Z�R�Pc��Ŵ��J����@�N~@�l��$̒3���<�9�H��'	 $��NwҘ2�3F�]��/ʾ�za��~��(�C
<�?1�(��7b���TZrV2�[����BNz��"����/ ǵ�pߌ�S��pՔ���N�<d\�f�ڶ����쐢�)���X��uHOՏ��E{�u���ND/6��e/oyĮ3�`��#���1@�*:�����St6�y�_X��.Z�꺞JmF��8�_�:wK\��W�]�#P�����D����,�僁�6�ܴu�S�jyO�{���G���E��?�o>��Kx(��87h����(�"9�x��%i寠�ʕ��Ɂo ȟs��~���N��� �ɢ�{BZ�3��4z�x�F -�i���u�)�b����J:�2��
�g�^_����3J��-�C���~��1��9|e�	�T�ԴW�t2�=�R��M{K�Y�`�r3�/��Jb���V
�M9SN�����N�K���+��4s��XJ���|�8�J_x�oa\1GU��<W�D��Ƭ�:6Q���x$��z��=&��� >��h5r�F�vlV�<obp��0Cn� �,����byM�M��İ0��7 �.�	
hȩ��Qy��ћ�l%���2�m؝\Di�ꅺ�)�JX��ـ�QE�P��}�SH��8(��İsP)�"><��'���?�c�ӯ*�W��f����f���YU�`f3K��X}�,�{Zʖ�7�����.���bzxf�q�G4��<pݡ�ݸ
`��$��,��y.ä��fx�N����/�v'�m��0��4�;�K����&�)d��������[�#fGP�@����	'�?�Qk�������j���n-H ��;��o��e���$��CS�/f,��X;��G ��r��_U��`4Å�ȗ������� �dfb��t�՘�ElM�Pxi��8���S�%�Q��U�\���Q�LY��2~�I�U�ԫDc����ɉ��x��A��Y�L�������I5�F]�@�d��0uG���n�<�U��qˌ�P3�;�T�(w�.в��*��R}�X�4��OT��L|�(6[X��Uq�o�n����[�D��A�D�\=Xc�w�Fa��{)� �L?�;�kf��*�4d�esc���}��I/����rg�iԍ�eɩ�U��Ye��o4�����'�"DG�j����M�������"w�ƭẔ ��$�.gt�`*��hd�ހ�}Q�i1�<���"�D��̂�:��ň�����і�3��vQّ�\�����(5&*͞U�E�D�6�z7`uu ���c�߹Ê�a�`�p��6��UeLXf�!_���7�~lqۺ�� G��eF�#tɫ���Ӹ@?A'%1G�n�k5�C��l�A/(���4Ab&v\�����맆tO_�(_��@�I�,T��8V��/IPXЎ⃂�t*'�:sj�T�(����4��������:�~�37����qT7��d�3Gqp���EL��{1޵�������/|�bus�\�|�Ӌ� 
����Oh�����y�!�&�ED�BQ������qUDHU�VnGN5��KA-C!/zZ9�����c�$�Gt��v0����;���>���I�S���X��θ�e�'l4hnU�IQiI{��&���1�F�mU����{�����	�g���=`$d%w�����8�`��2�p33��(8�rY�R��=Q��[�������8c����1�Bw�	�iH�G=&���W���w�"ܡ�(��;����W�M�4�T�����@�	�A�5�ŋ�x����x.,��6.9n��@�	����ްGj-`[�vd��Gm$dr�W<�lƅ	���d2P�Vk��x�#�ap�+�k��G}4^r�da�c�q���
nݦ�]2��;��СgP�	��V2aĽe ڗj���L��N�����W�j��d�0mu�v������{�����K�­f4�d��g��8���1��G����Q�bi��u�1�\}��@�Q��(�c�W��D�.��ޟ@�0D��UE����݁$=A��h3�ܳ~ߕ2�bYR�)`���h��O��GF�����3A��ΌJG�+����|��7p�P��Rlq"��;����ugw�,������V4��`�&G��?�c|4F�Z�ot�Lf�p�Ğ�L\h��6���`t-�Bp������ۢ�s!< 5& ^L�IAjvb#�	�%KǸ�/X�����ܩ���NL�<�ف��+��!	��~�~o�g�P�8�>�XLߴ$x%i+#k��4t+���. �vog�G	k��@�k�+p9�����ʄ"��d�C�����)�ޟ�����w�0z������QR�}^mh�rO˷�Y��b}a3jjy|\�bǐ[\Z�%4l�ج٥c��ƭ���հ�?����*Wr�(ƈMT����ޭ;�JTkį8䞆�.��]򼁟ܬ��¬�M�5�-.�	�Nr�їo�O��A�#޸��LD�+��#��N�UB�m�^4C" 6®y����a���|�f�b\�Cx"}��P�Z��᛾}�ئ�̈v��&撆 3s��:Ubֶ.4[]����,�Ӽ��	�4�5?{#��s�x*�Aq���c��#���o�H��D�����@��L��z�IHjGg���Uh�7ct%I.��³Ǉ��_���/���:�ۧA0�[@�dn�,C�7����|IO-fT���&��d�5��#�S��[
��gW ����u� &�{�!< 3�q���	�8�S	��O����^��
���3��G�%�:�5 l�c�� 㓸�g��fT�}��40�@��|ؚ7 �6���3�&7�<`F�ټߠ����]!`�q(@�b�/��1݀jځ/��Fo����&M�����1xsB    �>�g��w�w_?<Լ��9�cFGojTs��h��ٮ;D����,���r�BA/�1��t��6�B0-���U"���g�R�c�B��]���~3b��ө�9��^��Q�E5tr]3n�n���5�w땼���B��k��Y��-��gJ'������3/�%� Ωk�X��_�~{��(!���Achi�a£���-Ems����W_8��Q_ܑ�F�l��7ۢ,��X/V�]��pK�+x��Jl�V�y d8��5�6*�Q׋+�<d�.�>F�F�1e^�!�E��΃&VވM����J�2tS��7T�L~Wվ�g��H�r�TL��xS���	X1R2�%���@�A'�R��*�pX*L;{����O�TwG�̹�~��N��)��T	z~s��_��a���x�c*��
��m�|��~���-Ƚ���\ό���3�2l>��+0���掖��6\���s>q�ix�ш�0D[�|��%������Ar�s��Ҳmc�G@����{x0e�������۰�ߨ��EZ��ư�s�(ݓuI;���ſ+������^}�������5�4jM�� 3@�R�/���ѽ�>lz�'�32.��_:�C���/��F�%�h	�.3�Z���@9�8#t�9s�i&5_x_�L�ub�N���1S<he鍩����n�r(���6`>�C��,=N��3c��B<oBd]�H1�E��U�{��lD��D�?�Uz��S�i)�e��1Y��6�s,៏��&A��(��M<Y�	GҠ�+r����oE/��u{ߌ�3����rj�bǲ���y�I���n���5�k����0#�V�[��ȋ27Yt����n\k��§H���n�|��o��Q{�_g�\�W�u*�p����)j/�/�o����d\a�3��d�h���5��L�h�c�~�Z36�>6߰�k�US�|�?hǤoF�لO"�U�`̙�<PB"�ؐ,�C��3��R�4��x�Q'�߲�5o�oL�z��6F_`�y��|�d/oa䒒~(����c�K��%�C�tL���w���u���׼��Y�d�\�{�%c��<QHo����$_jx����@h�����8v	H,�e��g�ڽ�-qt���w����P��]B�kx{���h;gn2��0ԗGg*���;zZTb��c��R!}y&�~���ѿ+u��m3��>Z�{�ܟ�n�P��gn����o�"�+]D������f%FY������%�Ê?\������������ ��Y��˫T�[U��bZ]ض[�bn��Z,��+O���˷Q*���g���ʀ�ń�"���{-�x�ٕ�L1J���/�+�^[�ޢj��Ǵ��G����I01y*yw0���ڭ�T�e/٠u�,Ж�02ͩ�
_V��g���\�b�9�/ǻ��du��]z	ZZW}ьz��I���u�/oi��jG�@.®�	����oy�[�*7]g�Q"!$��*D��E�����{Ȥ|_U7fX�����R� �`Wx���xw��*�t%�"�bM�U�7_GF̱[��}�]�b#a��,S�K�%��9�L8)\�3��A��/u�g��m2[�/B_���+EV	��OV�ִ�R��{:6�S\������_�<�=�ey&!2S�5�u�6��i\�{�ܮV�J��eU������h�d�3㍪װQ�N���i�:-aĞ�J �=�,�pZ�Ɔ	'l
�P��;߸3%S���~�^�ѹ��?$�J}�BsK�Bˋ����l��`yi�9�����W�5��;D�\G�{�ْbr4��|�(]L}o �ཽ;�Q��K0@�����<��B �t	P�򉹜�ݮB�D�o�����zC�*��ɛA
F/��ɯbᡞ�֗o����5�
L��qf��eps�ij1_�j[�ߋ���ؓ������,�E���-�9K�J�`��psGŅ����b{�}��Cԝ�^�������s��\���9�S�,�\�?�<TE$��H���I�!�HX�����0�:g���FIx4�h�w���QlG�va��	/{|�Ku�VM�Wj�� z����N��������\�_�Է����{��qw ������q����V�	��@�Y����Ti�|9���4�M��b	�_ݹ�B�����龰�������V�`�ڏ�W���Z޼��a�M}�76to'�<`��&�E�}Sm�`�
�Qw,w�\�@��BP���n�F;#F���B�z>�nbߡ���~꫁��s0zYH��i��`�)��x��v�_&��p�F�tkz���:Ao�a=�簂���&�E��Ss!ߤH����$�z�FV�o+��b�׷3�돭`���b��j���/w�7T��5`gn�~;�F�6`�H;�/��>�ͅ4x�3Z�Sv�?��n<q�X<	j,�������I�o.��'�U�N�|�n�j,q���|q��(��̎�0��>ge�3����ʎ��w���/��l�&���mp�{�I�"�%>myFE�	8��֔��h�FQ�o�EY����:����r��k�&B�N��s�FWD*g��4���h��=$	#K���qm�X[�7�W�2�ph��Ik�欢v��n2�����t�qq��A�uK@����R��TT�A�P���+5Ś� �<a��i��A߲޲whY�C�4u��*���9��H/T��dL���R q���);9�Y�TW<�t7F��h��AZ������OV�Q(����|Dھ���7��Șw
�V�I�@�:���I����������eFo�1+c��qw�)(EQ7�i�����NjXt/I;U5w�3[��f��F�����,�	� ���5���0�L�E�:�]~�'گ >¬f�(2�G��u�)7�#_$��#��Ҥ7���������g	ı�u���j���θ�d<Z`�����[���Y)��*U��<�?eFt������*���Y�8�R�(3zuAM�ش��>I�˹�)#࠯[�B%d3�r�������4�� j�g:p�k�f�-���-; ns�����&Qܯ�khе1�9� >��Vj�-�����'�[:IQX�9Yt�`����s�cj�	[���*��"Z �72������Hp�NT�LTΜ�_�Bn^����cL'fBUrH	�
պ`k��À��������8�خ�-D�����ťTQ1��u��n{V{xD��a��'�K�%�D����=2�]1�ϊ����;5JI�F��.=-L�0M?��b�~2��j4cMGo�s&3�Q�����nZn8Ҷ�[��n�~�#�/W�/lWw�^Ҡ�dMG�& >i�1�ۢ6���׻��m�s��#�뢾��+�Yɨʨ����;�?�_Z3�y&k:~ͩ�Ҭ;�S+��!�Mѫ�5�1�O����>L����rS����)���t�57�lk<r�ھ�uEF_��ܬG	fN��ly�_��=u��|�>��=6Y�QO�|�hu�{��W·o�ދ�����u��t�a2�������7﹛��nnn<#b���砫.�H�s+UU9(Vkn�����鸫��q)j��V������=�]�^N5�ԗ��#b:� �*���Vu�i��3�X%jt�_�}9�-ڡ;E��h*_�NU}G0����W8Қ�z$f���܁C�G�8-�]��r�n�n����'�qC��Y&m�%�v�2�h�+5��]ޞ��0��d2�����U�վ�2��`7>�	䖂�u�v���? ��|�(�S�؟�}}�(U5�ܥ�{e����a�;Py/}mW|Hy*T�9C9�������S�B�a����t��Ͻ�'y�:h��-� ��^7Ul�A��F��d�U��a�\�'E�}��h�����L�*2�L�9�g (7D(�cc2��p>���3��J���c��:�=��k��VMa���1Hg����z�h9�M����p��#0�kT�Q   �Wq�C��#,�"���W�wi��1�g�r:/�sq<��w��y��u��+� I�+�'�u�f_ex�ݴ����*cr�d�`r���wWϻ�ړk)��B�Vt���A��BB���c���\�s:]����ö��X�7��D��SP��yu,l��^�ؒw��9(��x0@E�]�ǲ���T�W�JbD�V�	}C>�(�G)eA�>�����E$�1+����q`���k/�s�k��epy QO��{���{��s�Ԩ��)�HP���Ѝ�Lņ[��4�5�	�/S��\���<��#�֞�[��%�وA�I�dC�M� �pЪ���M��8A����9�Xfc�������v'���1�i�ێ5h�1�{��;��Sa>�S�:l�X��K�V����ר��2��\]��U!oNtT��h�e������s���{�@��\mnͽ�ّ�M(;��6�������:P�N�h�tm�m�
���)1�mQ՝������4.lk�`�A��R�V*��?�M7�g�������e�y�d��'��ˁߝSw�|,���Vn�;3�i�E<������Ϧ}k�|g�g�.00�}k3��f6��כ�l@��]��8����{�2��2��z��3b�SSn���'�dg]�EuԷ�St �]ԀK؟��k ���7u:^3t���x۴TaZ�Cx�È�=p�R�����E�P���j<�cIy�y��P�� y�?�mPo��F3u����Q�0�ݺ�|Pdt��ch�����0N�vn��h���qs���k�yz���qPct��}���
�Q�x��;ck��r+�ͱ0g�hE���(��F�v�[�n�]}��I ��g?2�?�4����FW����[!�j�:�E����;[\*��Pj�}��o�*���G%����������d���_�0�)�V�}�q���}���?���{�P�#�"#���Q_Ӊ���u�q��+��w,�:��`��2i��	W�����b���[�t��*ხ��O���\UXi���j�e1E��$���.�R��llK�Tp��|�+�U03�Q�v�$ʅnOII!1��VFc=՚
���/[)S�&��W<�E$x#c4�Q���^pO/����w\��,J�triN{�g�1|F���UMWYNw���`"����m3�ܤ�c��x���j9&�x�PY��[�~�1�DEm��a׃v�e7I���������,ɡ�A~)aj}�Ȯ#l�m��8����9s"p{��=qFמ��uY�J�tS�X/������J*^��̆�j�%N�'#�X`Jn0m�n��jLۓL�S#0�V�?1/��8�:�V9�8ѐ?Dt����N����s�$�rv~�8<�Ĭ�a�gD>yܽ���:�ra`	���z����8��(�f�J�u�җ(���%J�)�Pq@���#��������.��<J������ެ~{O�"/���
F���|Yh�IAQ�|��XJ�I^�`��]X����:�      �   i   x�]�1�0��>E.@��eCHl���4*B
T\���?U�|�eǏ6[��DRѾt�Ð5y��"1@�qr��o��uo��R�񜃃�r��""/��o��      �      x�u�Y�$I�d������������:� VeQ���/ϫ�P0����I�'�W���z��.���U_���1V+��k�������T�?(������5j�i��f����c������WI�j}�WnzD.���,�9^e��k�<j������櫿������vN�<�=�����ž����?����z���{��z�m�߉�g����_k�W��S����^��'���������_��	���l�[��k�{��GL{�m������>~���U��qz�Yg~/mٯ������q$�M~��j��|��9�]r����l�v�Ǧ�WM�%���vm�Ζ�~P���S��ڳ�o�-�}J?ö��Vk��?��+���m���j/6l]�-_���Wk#�ςM��>�؁��5��i�g��~/��T�:����3���\�-�X���?�(E�8C]oU��zb�2'k���g�X��nv��{^����J˶��}�λ}B�n�=���O���e��j����v^j{��Gtۍ��-Ыq�F.��N������c�a�Yݞ�KUr���gL>��ת~�f��]�+�f{����E���{����#mG�#T��uϋ6����/���v���c�g��jy�����{�=�?��I)vۏ6��Z���ku;
v}q�{�iۓ�=��Q��о϶��n�9���{������Pݒ�{�nI�eL���8���Z�6zN-��ϫ5�ю�8�V�<�6ք�l�kּ?g���u�Ƕ�~�*<�u>#�C>ϐU��j��U1�`��g�������O0D�2��셮�b!��%���y���� �3��0�ު��)�Z�^���-����7�o驱�kٹ/ۙ�&�ָ��S�-�]F��ƴ��r&���ų����پ��1���k��^,�����}��v�͆�3Yv������y����G�����^�72ٮ�e���n��k��G;��NѾݎe�E+"�R�N�-�/����?g��3�-��q��Y̿|����n�����u��v�C<����'Yg�~��г�7�U�}{�cYf;?��a/pf�ǎ`V��/�i�ݱKk��i)����G��\v0�f���}�*���
��ӷ�k���Yp00��?��u��sjq{i��W�g�#;5�},v��G��o-P����&G���C*�
,Yq~b&�`�6�c�c����s
l���E�7��if�6u�v�0�֙xx�A�[��J�C2'���]f	S{��ٴ�*��X�-������:�q�-5� s�qX�5��!U�>���.���z�l*X�K.vJ�msӟ�������L3i�v�����e�I�bCQ�myx�b�V��E�rhٜf.�u��m�0�l��kM�ԉ*Wk�$�?�AY~@�x6]��+o��]�wƶ�7���Cq_������9	��9��aqs�c�9�IL��H�|.67-3d{��϶3\S[=|C�Ҿ�ƹ�9$��3����&����캢��c�ጭ��k�5m���q��1�yF�k�[�u�v��~���u��et9���_�̺����]#������5��w'W ��s�mw�O� ��&`x�:;^.�NbS���u�x��SM��YS=f���Il��1��~>��X'�Y��,�]�(��ǆ����-����bw�,!����'F�k`F�4���j-��FȂ4;��!v��k�O���5XH����e���t~����y�?�� �Yv-F���<�o�Y�iJ�-�2�hq���1*m}��1�����(ŶӾ`���[��yv^�O��am�v�:V��ٵx����t�yv��~;�I�JXA����O��	I��ֈ����b�i�)V�е�+��Z6�j�~E�v6-L��U��͙-��5H��rs�T3����\�T?'��:�@0E;�Jϟ�p�[��b�ڮ�����ْ��Z��ݫ�/��ڢ����<7"U�3�D���+�B>ǒ"�M���P�N3_a�Y1�h��k̋Z��g�b��)��-"){/
l���F^xmh�ߐ�v�9�Dxc��7]h����%��OY��Ni�0?ř"�̈́V�'|Lt���X�RO�����_䔙M���cjt��l��ʐͦ�aђ���.�?ҕnbj���6f���>��M��$Y��gid�|�m��1�s�@s�"�+����#�&p��Y:��l��MK�0��r�q؆l����l87�O~n�2�~B�E�e�/�eí��Ȋ��A�H�Y����ο�K�ϱ�(�(���fیq@S���l����d�#�fj�~��fc����u�pe��	</�ڮ�X�:��GpJ������昫��Cv�����͊.p���@��4�o��6&IHJ�A�o�iy�hý�%DDךt}��U�ɬ�}����V�2�G�ڪ|am��_x���o�B�n�pϟ9�oܧ%G�P��q@w#Au2��vA��m�H���b�u�0�9�!Q�O��ZU0>�Jސ��^z������aWԬJ)wT���dny5v3m�o���4��9��	�c+���K����}��9T���Ml�����9����L���*O���:h3R��f��]iC�p�+�r�f;i���>o�Ͷ�G��N�٬@����!�H�� ^�^١o������M�j�V�n��z]��T�
��o�Ŧ��n�}�]Ys8�=��"����m!�X�\j�: �;	�+7���_(ـ���ڞ��Ѕ$���坱�蝿��L�4��a�lN�砭,�-+S0���������Y��Dje�j�׳�P�!P���u㦭���D�ѝ��b���$�%�L5���PͲ�p�����Q1�_��gt�P�߭��ؚ�ڤǶ~WT�k�D�R����4Wm��T��k��T�v� ;�v��}�o�h�N�îA�(�������x�~��&̖�L�|h��l6bv=��+a��0�	�fDQ�Z�7�h�����x(^�k��#�5�����5�OC�usv��]j�8�����/7��Y����m�Pq�Y�	�����E�լcy��o,��J��X�2�`R[�:? ���M��M�T��
%�0�	
��
���I%�1._��a����J/l�_�:Gy���A�t+(J�9��f�V��|�?s��X&o{=��k�](ȯ�S��ثֈnv�8]��ҭ�� iV�vt/J[���T�����@����mv�D'ʹ�cw��
[ط'��F�6�F,3����w�Z��Zo�3��t<Q�i[~@YY�,�f�-���ެO�����i�<�Y���>��am?�sc>&4���#ݹ�e���_Є���ǓMT�f��'��H}΍ǫv��-����*Ё-tq�k	�PZ��m���A:UHs���f�xU��E�BB�����'�{�ȿ�P���z�C�jK�(g�����j�(F�1��F�@�19C�����8_c���f � �*8)_h�#>��z���[EX �U��unh���Z�	��|j��<kR���}���ő�����كR/H�keo��xV�([j�J�[3z>#���P�݂L� |q�͑�����4�#ŵ��;��]�?g�$�b
�ǃ���vKp*�����_�Z���"a'7�vUƅ�[��������V��#Uc�)����p�E/���#;��W��v�!�,�1�\�	-��t��l����_�A�Q�T�m6����y�sos�_m9`>�0g��^媲��26�	�d��ve��� ��H2a���8��g�%̊�V{"��Ы�u�չ;p�������Ay�e�����2u6s!�h�0�R��؞ι�)��6�`kcq�#������5�r�n�B�L������`$���S+7���B��|�Q���g�s��A���Pv��jLe�Pp%�L��d��e�{����U0�|��_AQU
�07{�_c�X�y(f�l�?�-����&��e�f:
����D��%*-,�?2kb��V��Q�4A�E��y�y?������]�ya�S�J0ܻ@UH��|V^��h    �����v:����bEmjB���5펌�<�Eƹ�!U�T���^gY)
��7�a�.�ˋ]��|;��t��C�f"֏�xS�8�Y���l�@�W��x��8� �E{J��l��-�p�]؝�J�B^w-AVə�K���(sT�� �-
�u^(���D�r�b�=T$��8�r�(�'b��n=�k�S���l%)����x�Ѡ��1E=*w�"SP�b���&;�/��b�3��L�H/7S�L�y���_�v }����7Ԣm�8���Dr��(�O�>ϒY.ѷ�-�+f��0_x>wt�Q��3>Ԃ�� �}`���k�D�|Ӧ��
� �ײY�p�;���*7����6)E Ec��3ӕ���eV�w���d�D�:�;��P+h�'�"�������Aj�bV�u�yZ+�OU-���A�F
����� 䨃M��Q�$�3�$�ݞ�fĬ��*7�tI��^ ϑ�:����BٲՉ[�G4t�O�f�_p^�Hx�1�++��۹)\�� ��Zt�m�W�j���V�s��G��{� �bn����S��ćُt>2�f�]�B=���s�rh'��Ҩu���1�Y2���
<U�C�ۖ�j(�p���x�Z�g+��rV=|ɵ
ھ׹Fh�MDy��[l��������ƞ�	�;/��<8_���h�7b� s17=,K7��!k�.�5ʢhŮ�-x���0Q)j��g����5E#�4�@�qq
��(�pV�%��rW� :�@ �6�btbY�&�8k� n�lg��tR�p�MMF���19l��n(���v ��Hʎ�gEN�̻���ڹul��}�T���(!���;�!� {p��tDVE�����}bpN�<��Զ�	��G3�W.�D��q�7k�۳�˸�L��B��gt���H�W,��@vN]�ʂ;�3��Plغ]�U����.�U���Y����!��ǿ]d����6(�� t��Z����~QP�@6��},�&ȩ��6���=�nױoF�J_��M�퍊��g�\T���h��2�����9D�����=̀o�%a�=�X�<}у��y*��Y�d�6Uz��x���!c�S�U�n�6��rp��M'P,ŻQ�ߐ�% �"����g���Z���Z��|@r����)O=���H���jK��K P����q��ap�`�.q�sR�L/7����z�F)�*��/��2�UC���9���k3�d���������ޯ(VQR#�j�Z-!z�`Z�	s��%��?�c|��� �9��� ���(�3�p�L"X�p�����ɫ���v/߄I�ALE�;���"q��>m�ڊq��XdO�uXK(��f�ZHo	��5�e�O.O�������<yg�GX��=tz�+�{�o���J6��'4���W�O}�)�Ͱ��{ ש��b�#?�p�	��t*����7�U�(�#(�>;1�v�9�SL��.K�h�����-�aۿE����FɎ-���˵x��R��	�7ע��`�1���X�s�W�`�Cw�����*ȌC�]�%3�X�'1�;�y��l_^� �x��lq��_��1h+��}��$�q�2�s��>bJ���������IT�<X�"��ɨ��ݲ,��3+)�x�j�M`�`�-�Y
�Wڂ��ڛ��z<���>, :o�+y9��`�C+YK1�H��kg��ͭ��Z�!���W���Д�3�o@9���6���iz͖D�'����#E�l��9_����b�]��S���U�����*�J�򺜨"#>f�ӑB2�m6o&�`�=k�*UM�����
>pT���g��8e3׾�t;ͤ�S�H�D�5_���k�e|k�\�K�"��͜�3}˔�Vz�0�t����y�����
�TJ�K�]?(�c�%L7�Uޠa���D@IPV��ē�0�"._�5S���p:��'�*˲W#�~�%�J�&=NB�zV]�e�H+@u	�+wv��r���**�w�>��� #���:�ތ�5n~�W-�H��Ş��O)ś:H���21�����ۙ@Z���� ,���b?��űYv�/Y�`z��`о+5��0��S�Zb���S^�w.��Pd��[;$P���޺aX��F<�EQ$�]�Fm|���`h|z�J�zL���+����wDZ	*Z�����6iӨ����� ] ��^j��I4+�~��D��@���r��s����H�r�vS�$�d�Apj8�����~�zm�)R-�p�B�hn�]��oh!�F�bY�۹�!��D!W6�>�,s�����o�c!�3H��_�+yd��薮�����X�E�g��/M͘v�!7��a{0��E�9ܦE��&Hv���j����[��&`JvK�Q[�ԯ�N���-��ur֥o���K�(w��xJ�OH�ܖ�)T�����a�����-���E4�Ĩ2�6T��3����o���@�Xgq/({���T�p���ɫ��&��� GZ���>D���W��ItY�SY?Z��ˀ�����5��֎XҎ}��i���������#H[3
�`BW-�!�!B���>=��[�;h�oV����"�/&����(����x����hl���	k�Eˊj{���(N@��XgJ���~²�ү�"�-�F�7z���,�:�Y�5��j��i���щ�k�f<�؏�Ql�ؙD�xVHo��a9����t)�$[K�WA$DU*[u'{h��3���I��7�Z6	'�%�i�L� F�U�_f.xHt�A�J����}C�����{�#�������{���1)���bpE����lj=<֝۱�f<:5��M�Cra�^��>�v�XЅ�Q���n N^�BC�B%kX�,My�/&��.oR5��际��Fl�OF��Te0c�r��M�Cz^�����Z��f�Ӊ�(�@1�ݡ6��ڞ��΁��3yJ�.,�Dyw�*O+HK�g�;�~����ь_N6�e-8�mz�V���f;*-��VsM�ӼR�xh�w�~|�r��s��S]5�wAc�qz:���T��4����N�/�5�dW^@�T�*9=���ͭf:�ʉ�u�C�&��O�����|�.u	س=�t�b��h�<p�ȕY��g�V�	o��wu���%K"���4'Z�@�{��f9w��4�ޝMN.��}��#�IhV>^n�m�þ�]�����<�o���~|�����2m�w���](X�}�S� dn �ynL��)
���8�|�cV=�\7��F�\ֆZ�ty�UF?��{��}��t���9=�E�0{��XeE�,J����	�f�{y�2�%j#��!>ͼi�JX����F�A��n�Gk�w7�7ӊv�F�y��5X*�����|AJN�ً��Ts.��N	V]:r�G��~�P�	��I>��y�a� ��L���aǂh;G�ֶ��Y�5����O]M����z\{t�(��M��+�PW��*�S�z�W�?Yd|ʔq�sAQu<���Q�,��e�
��l���E�O��Vğ�����<��]��y���<L�l�^�7+Pur�f��C�'v�����N�f7ad��R�3pP:��)j6��-��Ҝ+RU��(�xg�է-��)��^��4P*���9i6�$��FľҺl�3ۄI�O9�*�v(�V�wwt��3��$�<��㖟d�h�Q��8��O������z�7�q��������Y�:�j6���<�D���,b�5B }	7�Q�#뢢Cr}�d>w�Q֕ꯁ�O�������}W�
Ca[�%��������2���]�­(���5.�ʄ�F�*�Xz~Y���"�V8�F�[Rd�!V������o*1���r��9�Iya!�)��dձ�P1�;�xhCg�o�h�o�9a.����8�ak��OY|˲ӿ��U�-���������an<��˶��|y�`��6��9~�\W�/����F�=~\,\p�G~9Ӫ��}�@E�MݯJU�g�/:�=��e1Dt�o����7��}U�{ !;�7kf\���]v    ��r�'���`�r���ˤ�VM�U������O�SpW?�Ԉ9K2�EE7�4�	���Oף�#bK�7.p����ZE�5]
#���!َ�&�d�� ��Q��u���Ѳ�b7_��j8�<i�7]��e.1tҹ�(.-���fG���V) ¸)S'�q%��џffI���,Snwa�$Ұ�WʸL@=��tp�tG{-��i��'R$��o
O��D�BN�Yv0����fr����(#Y�F� �$��/3XCx�H��y�6J��K�svQ?Mf�t<$�r����V}�m	R�t��g������z&��B�,(���ս&��Ŀt�����E�B�"�A��b�.�;0D��r�=��Rp9�ӣ9�.�i���E�[-(=E���u� �"�1�u�y���Q�T6�r?s�ۣ�\R�}D���f6?־9\�gwZvsŀ+�z�>�W��>JC3a�a�Ѹ��m�sa2�;O`Y� ~c~~�'[2j@�a�/�;�>�ɻ>c:�|�-�1��ͩj�VC��7���h�L/�*Y69Ԡ*�[���t���/a�� #V��%\f��ru�`��G��-7�b4A��BŲ��(R�S@�H�Pҫr�p�/@�+��=��[w �.Pl�u�f�ӷGp7���XTk��D�8N@��l8-�^�S������[� ≆oB�`6 �xw���M��J��V��8(��T�����'��"�G�&Uy�[�&�Y
80q����
7�v�Q���&߶��_hG�Z��Pٕ^ �����{CD�o7bݮ L����h��L�[�m���"�H�(�)Q%= z��6q%��!��i����UZTC#����g�D9���lU�Tq�97{ j���Y'N �Ea��uCr]5w�K���奼�}������I�q�w�S�G(
NJ���P�u��v����x/J��Y^ެ?�l�y]�ޙƝG�0��hL�D%�VdZ�nU>�b*U�n^
U��kݡ�]��#��3}�D�3Ĉ�+*zEi��nPD�	�Hcp-j�D0�g�٠*�nP��̥���jTWk^j��i��V��K�g�����Rvx7��ݰeȚ��V�A�l�hߺW�x/@DF��<
|!ڒ��Ĺi�r�xfI"XFA�s`;}1L\eO��X�>�A� Ѡ�(��Ө�B<=���\D�fu��vJ�M������C0b�I�;蚃�	����&i�'�Ƹ�QA�ӭk���f�LPv��>���[�&Hmi޻sx��r�����dܶ�q����|�
�|h-���IPwG�X����sW��)�hC���Om���r*�9;=uM15�G�D��-��}��a*H�'.5"�ծ/�O_h�����q�c)Xz��S<��� KJ�(��[�R��4�,��~e�%J��<�u��}���+!�h��>P�Y/�#�
�gĲ"$!(OL]������4���:H�%Ut��v$0��{�t�J�O�D$U��@�������_�G���f@�K�4��rӂUx
�G��J3+�����j�[H�	��4m���"�D�_���a�&rT�r�O5h�Y��"�[��{���-�~�ג����8Q}r;�R���U-�
�8g��2�S�jH�b�h���~&�L�
ɠ��eWV�`R��$%��+��=�Eo���"�j�+�������'��M�{��&��Ma�',�O�G���;�����P��ۀ2�j�?��(��۹7P�����x2�H҃(���:��m\�Ĝ9�o��tL�@z�Ň�)`	$S}�^���V����T{Ֆ4a�d�����vpA!��;$ ����s�=qYv2��#�t�Q��]�v��D��`��<j��nf���_�J� �tQ�
��	!��)g�We�3~�є�1�E��q/��� �8����YG��}�V���9���9���_�,�����<f8�zR�������D2��/NWrIw�|Gv��t3@{?��< I�R����
�_�t���@)lM	_����Ԙ�T���<��հ�?ܭ�G���E�&w
^��4lfE�;���:�YQ���B���$�5<�}�jRn�#��,i[�k(
�w�]2m���� �1�������t�#������*%a h$�ǭ@!:G��SƏP�������m=�+�5�"�$��%��jΈ�<�"7�J>�%�Q��89�3y����]Sv�����[σ#��֋���U�6%6�N<�}���w�* �s�͔�Qs��n��'�� M!b���ѓ��b'�:��T gH�B�'���#�4B�޽�.9
�;�g��}�?BC��8����ݣ���A�9�S�@x�_�����`ʊi_�"�؎^iˈ�M���� kfg����J�YQW��~-.\����dӺ��D,���%	4t��t��WԨ��@�=��@N:�M~�e��[�d��= �(GA��j!Z�=�n�Hs���]=��6}z��I؟Z�Ζm�[�ި���O9k��A��Í�mR���'�^o�SۄZӦ��z䘾Ў�oe	W�2�׆�5���	�˔�p!��a�.��Z��DQ�(T\�^���|�	��ީɹ����L������J�p���D:n�C�����F�r�ĐP��-�P�3�)ln�wYx2N��8} ��i+d���h���ɑ܄R�D7���`�����%��,�p�չ%�y��&Nuŋu�aj��$�K.q�˻߬$Wǘ�C�LҲT5\cJ��Y�S���I��acJ!K�r�������^�oJC6u�ƣ�g�Bb�(���#�y��W���?��&�KZ���(l��H�m��G�ЃDVD���㯛��t�;���2�;��~n@�� I��!���	KNJ!]�L�!��6���X�<�Ҏ��.��?�	ӟY=�j���*�E��+�H�����.L������z �����/��D�!H<о�_���9�����j��h˻r^����t��ǆ�/!��Aۼ�<G�� q�"hKs�Sc۸4n=�#m�Sp@��Y�����o�[
8��~���G��
= �$�{œ����m7L5�_$�W�o)��=
W���m��,NI�Lʃtzbf�;U\�.��#Q���?�a���X�P%����pR��$�8<s�R 7n�j��H���}��:��H`A��t1œH�HVaC��1���Tڑ��2�*-{�~���v��ȩ�0�C�Z��5���8��(�뛳JR���Y����6U�b������P�h=�%�7k)�����/�����p%�jw�1C�d$�H��&��Yp�>YK¾�{��kQ�Y�p�����(�4*W� �����)��S���kLQ'�Y�\���Ʋ�'�B�I���u�,F�Y`&�2�A�b"�#���ou��.�"t�-�R��q���r�8(�*�5
ffI�e�~j�*$�����{��vy�*����́�39�H���^*9,Թ	#��1������S�Vx����G����2y�*�)��D09�4������N��4��A&���4�t����ʰ�H<[�f��&X��ł��v��Fj��x@od<K7����d�+��W#6i�o��wCx��Ê��&�·*��x�*7�Ŋ��5�a�^ҀH�6I����HK�Z�Z4d(Ψ~�%ݎ߼��SW��aTU��xL��6|؛G2��i�D�h��$���>(�J�#������X����6`IC�q�%4���ŀ�'-3>�����F:U�1�ѵ��-�ɽ�[l��G�\��h��Uf_P��n>�����R��P���|�r�S���REU��-,_��=��x�a5z�!����JM��(
�~?)���Z���o�%jB=_�Q]�7�[e�+wm!{��""lIƎe��°���=��@p�y�G�K��u�gG�/��vX��a���[�n�辌g;�-K=�r�fl��H���0����� �� �5�V˥�i�"�v��D4v���͗�Ac� I$GE(Ά��cny�=�cyg�u��)d�]�_�ѷ    h�hB9�a��4�6Q�xk��'ʸ�O`���t9�S�����E��P�	�x�q
z ��i?j��b�9��pFži�L�3�l�WW��)�LJ�4;*m7�\s�靇}RG�Q�(c]��s�h+��ɞfL섁�bF�t�hx
�"{\�ZL�Y���,��$�HPߗ`j�ANRL��H�n����V�	#[Ռ����I��x
?M"\ZP�9�� �����:���M�)^�ɀ]���r����,tI6�p}1:U#hX�lg�!��	��w~�Zb�'&�kjW{�DrS�>���-Uك�f�t~�	����x�|�OVY#�U�g�&���.�e�j%�q2��{E��gL��u&,�Yd$���<_5�P����==h7��]C+��#bI�yj;PD6L>Wm[t]iX0���ȯ�$�T��onH�i�1Z��A�iXQ�1"������~R�7ː���5)�qT)�#6r�����Z �E�E}��[��55�0]�ڣ�y�7z.�C+�ļIY�B�����g��cH͖�|��U�*Ѳnw�@2��X&�iK��N녯Ԙ�0��W^����i��X;}�)�xV�4��BxiC�J�ۗ�&�Ir7,��#����I�no��o6��ꏢJyw� ����q�j�RQpz"�������ŗ}(��ʌ�YZ�yj���g��4cժjoeM+Qݹ���Y(eGi�K
����һ�cF���O'�8-���t��gQnz2�1�
�h�U���%[R����mɌ;.�}+]{bV�Ϝ����4��L�¾C�Y.���a���rP����)�����z�O��[*��c�.f����yz4��v��;̍b�'�{ +�Qe�� w�����1�<���M�|E8;�U��~�>�C;i�XWo�'ȉ������KY[,9�J�J��[�șU׻��T�bj���3����t�e�LǝJ��ޣCz����)����(_�غ������!f�>�6en�}T��W{��2R����9�*(��F%xR��@���\hREU�P��(!���j><$�_�q�O.j(n���L�����]�^IP��-�+�{��.�6�w���N�w�4��k�g?���O�� �v�"���k�ԩKƫql����[����R5h�k�JH� �$&��rL1r�صߓ�T�c����HZ5��]M��̰�}��~J�j���L [�=C�V��zێ��C��Yb'�j(���{��t��;l�#I��)99NZ}�6�f4M�9�`����$ȷ����=޴��������"�����a	t�.��t�w��t��u\��'�!b�!VT"�dZ��`j�U;5���(�e_����,�F�f3mB���c�aMV��h{\�G��L����fO���0�/.[�Z�|h��OE%����~�rC9��ذ{�c�ۥ+,3Dޏ�R�P�;$�#�r˵.f��Qd��ɞ]�"0��F�)�����~C��ȅ*�gYn�ݭ ��w��9.E|��9/��<K�nЕ�2�Ԅ=u�$��lk�$�F�ݢ�$��sV��E~�|eݪ��s��
�J�.ܸ�޸N4�DNK�5�ƴ,&a3/h_��#���&ě�3�a$�[�����>��9� � �	�s��q>�m�o�Ѽ\2��Mu��O�tFE"�pp9��DN�½1��n��1�y��f�G&4"���Lߙ��#pfi�XB_���OЄ�����%a�B3��WV�zY�g牴����S��HE��f�Z�w�+9)�qp��F�Z��MQwn���l^�����4pD#�2|��ti�`�}ɺک��\�p�'^����4�/���c�]IP���ÚM�E���	���Xm'��U�r��~�NP��g��ϡ��Ⱕ��^���0ͅpIU��Gs)�5<���7����E�ѕ�S�A���/�LlL̀�&��. H D���h�bi���O/i���B�$v�Nu���A�9}���v5��-k�LS$��K�C�{>���a����~3�5ƺ�$�T���|��4815ZT�?�C�0������{%-�wG�QI�G���W�t�	v�I����E�H���>zC迥�;B����){'��L�I���9�B��\�tU�4o��!H@k��J=�$?��в�N�'JۢXX������mX�x�*�9K�5ًd_u9}�8h�ܵ��t��̬��MQ[�T�cCԴ������lř�ϯ�w�~�%�^�}��æ�"��M!���%z}^N_zL-�?]>Yƙ��d�뺸��;ea:SOJqJT�bWB��옞�J'���X_�'E1)��'�f����g�#���J<2
���e�]����������T?�����T9d����	^���.�+Qږ�'`c����8�~��GLC����OLWt�i�.j�����9'��u���I�$�:5X�1��������S�jQ���>Xƻ}���T��_imZ1�:�_��w$� 6��z��(����*� 3#��G�t�:NKz�@����5�C�b�j�(o}Qq�x1����˶
x�T��@�0�WC!�v\��-O�8�ڒf�S9�b*\�����MR�OmjO4���O[+�=x
MBD:�?�	����hc��d�٣��V?4~r�S�7��k(W�j��ID��Q��/�k�`o|,r� �Pш��;Y�� )M��#Ps}�PI�ni �'e�K`w
�s�7a䈅R!sk��l��x���e�G�y��X�Ss��P�K{v�(R�[��3_l3���P�[��CE�ґt�/�%�x�f��W.̠Ǆ5"B�c�+ hZD�\�C�?3W�4a�OYb3�P!<%�vL�O���f#�O7���b�|3]JÖ�2��xG���^�G�\Z_v0��NE0΢G���L}%��4xk�R?Dy;L���6	1�/�ٗ���:3 "{���7��\�[�-m�++��S�a�.�����y�?�C��7M�.��L�w�~NEK�R�>��}�y=Gl��n[S5Y=/��:���Kzfl	�LMe�@.�J�~�=<dl+�E���P ��>�&U} ��~܊�[b��$�#J� 4��ޘī�X~������$"� ��T�C���&������61ų=��Lz�d~��Θ�S4�M�f���9�-}�[둧'�՟�'��eޣ;�~��Z
�o����S�gJ�LI�%}=�͙)=L7��M��%��G�LX��[�i��[(L�q���8[�CAtU�G��ިc�"��M��.�H`\ږf5]�h K����T�����%M���`�*��G�X��U�)�Ŀ[As��DE�p`��,)����5�+���Chh��1!���?5�g&�lw#�)�[�%8n��K���s��xx�4�uht��U��]|�ꖪ{L��}��ʮ�����9����b���(���8��_�)7G��Tep�+�P����TlU�G�E)ըͨ\���c�wj;C}���z~㠩T����3�RJ,�O������A��a*ע�`N\�?%i�H۩�Q�<UEU�ꉽZ��/�T�Q���Zt�р��c�t���ԙU���v�(i<����
��!��G����-�d���i�L�)��<.�늁�SEZl�����U��)�^��#�V��M���,a7%���K�9z:!&G�65ʍa*ҊT���v���ܪ�>���xW�-��uU�v�����Q���y�oLSkn�g��;�!��{�ʊ�V��N�҂3�G�w��|�v�=�&�ӾФ����o��!�Ru���/�:ܨ�&o�_�R�G@�iG�b'��Qjxu���M\Dask�a��TF!�tņYb���'*����$���7�|���N�1 ��?XT��!3O�EZ�R����%�V�_�bC͠�dO�uTP3��D%Tf|��8E�0�Q��'�W[Qw��y��8ԫ���E�g�<E3���T*���f� ̕ó7Öuw��[��%��7c_�/����$�@Ã�.:�O�c�B�h�+ܯ�a�P�ttRwu&0�:�cd��s>�t����hC��l��-��B    ��!p�QpbQ[N��$��rK�9�u��H��Р������%����zr�Y%�܈�z^���˅.�G����%+3$;_�cp��Z��Z��{3�:-ڐŇlW�2���ї��H�	�1<͇�$£oYu��h,���$�JN�bhyᎄ+�c���;Lwτm��z��K EFh>�-��O5�^ي�S�4��,ĭ��4�3���?�(�b�	H�C2�!,���<�Q�i��GGS}vq.���(�u��c�Y^�!r?Ɓ�H\�{cq��%/5[�s���|�a�%U�B��ԿZ�}-�ie��5��l����c����w:"�P�h����U��a�+�{�z!����u���
�#��tѿP�6�ZIUQ ň�KP|v$(Z�	.�u�d�n�&�z;=~z�8�L|�3h�u�\z�+A��]H�'�z|%�����D(i{'���x䂋$�-�o�� Gz<�P�����nS��^mx,�E'f��y��_�n1s�����""���PRҳ���$4�GlG%�D��ҋ�k*B�w@�bn*��� N�ui�=��=�5��ylX4�Aǔ�#�g�x2�(+-GY]�.Ǡ��$%�x�Y���B�g��ev*6k���Qc��W9E�F��&A_j�~�K�H����!� b�N]�9k� P��,�="f�܆=W�����b���ǆTϮ�l7KM2�Rx�a���w�~ ���o���'!��3*RhK�I��L�5�*/��
����N� dA�f\X�S&xN�" ��'|-�⇞�QE�7���260Q�:����������T�rf� _i�0D�\7����]�����'q)o�D��<�:����᭫�u݃���/Jvc@�<~�-Ax������l�����n>���5�8��n�PbG+FJ�J_�F�/	v*֥���Jj�D蠈�{��"�T� ��Jz;�P/�h�Qؚ�lqų�{���gEd(~�f��Q<�T7_�}��C�Y��Z�#A��W[Qߔ>SJSMf�v-�fe��r�Kx�CjJ���=�7���ΔB�zϴo�mk���Ѽ�/���>-�)j�3�m	\.�����l^�ߝ91�s��)�I�Wy`R��yʑVn]s�ckv�ҴO��j{q�6�#�:E��ə�+B�1u�T%l�E��p�[N-�jȨ�[U�^JH�c<���B!���@*��ҫ$��U�\|�q�+�5�񉶧UHB��h�t� p��ր��X�}��W� ?�~֪��t�歎PB"����$I8�<�����@u��2�FCY5�]� \�f���qUco�R3����%I�B}I��0aޅ罶1�ޒ!��3r�&��
�az�3�%@��:ST+=Mn�LJ�#���h3\ �?��ddJzW!'�şN����p��,�����އ���
kj�!Q�j"��$5fNd��]�8m����b�fI,}:p^��\QB�I�&��V��]�+ˤ�;�]����B�'9�W����wYTlz|r@�E�������K.���;mD��z]?Ibu�-Q��M��r��pА��a����)1���u�M/��K��['�[���T�7�=Ir,�::�y�������{�4Ӟ}@vv�?u�v��U�E�e���ڒ\�LK�>J1oA`�晿GE�U���<;:�R1������&�y7�h�^��GO�,��qV������5>!9�r�J�A���Ѽ�3���vXLhcj�p>?��P;���4?j�o�g/M7�W\�wZ?Y���h-���zO�����!X����Ob�v��b���ѐ�۸oC=���<��*t���gQy�Q3c�!���f1,�Y>%+��},�̰�E�"x7tx��d8��z�s�Щ��\����@�u5��}�S�����&���U��L
>���>~�,�;PbB]mW��{�?��*�o�Nsd֪OS����Ԁ�������r��O�\��>q�B<��&��i#:\��˗/��\��h8��!�U��h���@U�Gh�`���R>��t���'W�aEr�Y����5��z�5�h�S�s�t�"�C�h�V�!�>Bw��A^�4�y�*��$�s�{{�dA�8IYt۶��(�8��>#��p�7����-��(2sA���/-��4ęy9��e3�[��^��}:W.9����`Z���\|.J}f"E+Pסq1Oh��C����+6�A��۹/�&�	��Z��5ƺ�½؍�Ik���$Ɍ��x\�]}GZ̦��qƎR����g�	������-��wk�˥G�{�,|3W�:j�P4�Nȧ
� 2B>`�w*��\�����y]��N?0Z[>���ɋ���jaT s�D��Bb(��O��74���Yr��_���� y2��0?,���#�����8$�o�m�j0Ն�%�~��һh��-��-L!b�W&�N@V��#�����~��̩�V�FS�v�q�r�.���J!QPy���#nTV�����v�v>x������N��?�AQE���=�8E��F��������o��3�� ��Wba�X���A�h��TK\H��f�ǳ���Dr���)�����3 +��Ilbj�
��hd����]�N`)B��,�u��Bʣ�o�0�V�ot�����~ 
s��"N	��D��\*#������;�4�q�,�����Ra�"�}5L�Б�9 ��Ő��nm^�_�?>���9X�Rd�q�Eg�+�:��h��sO=�2�=��n��]���j�oI,Ez)E�_��3K�T�|s���W�ּZoOz^v9����5�r���X���E��ąs���\�>�z�&q�4B�>�8.d�)���Oh�i���.Aʏ�I��RV�
H�,�f'�H�T�r�n�7Z�0ۥ��C�J�I� Y1�Fe!�0�8�����&dTN���j���_W!��������[:��}$��bh�5x� g(�'��r�1~�	sU:_��8��Z�����8l�&8eH4I�fV������RG�����Aʲ�L�����o�ۓ�$T�"o��@U�>����������G�ԣ�-��-ێ�@}��-S�Т�6��U��pCgs��.jDIVj���5ۃ	���$����Q����V�:Ò�έ=�t!��f���?�"��dVc�� �Qh��5`[�T"�Eb[�g�H��"c��
9���4%RKŸTTcN���)t45�	�lj"�~��着�C�U��'Z�KX��|����ݠ���1N
����Ev�^�:���0�;�<�n�Ӑw�ͻ~O�e$�QG���(���-jջ.�S@��ev>)�)�g��\�#�k�{H$�Z�9 ���z(��S�`E���ïq0�+��xLH���h�f+���j�gӺ��h���DEӥ�e��w�P���P�i���rPʒ|A��?�S�)�{�c��g�l"�M�<���%av
�˯�T*����w��=�l��3�X*���N���=r�Ka�_���e���x��\�`��=�Qc��Uyh ߅�˅����ؤ�)GP\�p�k�k��Ł�M�Ρ��o9��OL�"�v%�}���	�s���y�*<�[��h�����*|c,�����",��Hu�&�*�w�3�%�h�Մ���FoMC]��:ŮBe����d�E�%�.�����P�b��>�vТ��T
�J#�ڞ�DW��T0��nG�����`���*�.�H��S�``x)�z���č���<'z1̲*忤G=?V��?L��5nX�.�����}B\�!�gPP5��f$��t�EvDN�['e�r�#�(�3~�r�ڋ�8[��u����*YX���"�@/}w�0�����4������Jju�#��` ���v��8W�AWc�1�� ��IQs��*I�	��#⪹��嶘J	Y��[�ף]����w����"qe442e��)��1��
���Ku������ا2������ )�GR���ڨ�Q%�<�� �0Uw&YQ�{kw���z����Y���HDa�SY��}B�� �  g��W�p���������YREݡ����H��R�&���bX �I�뷌�M�vnH=9b�I�Y2N��0-��jyw�R=�BګO�0'�Ԧn�YCbNM�4^��\E���w�����+�O�O.���cv���S˒�M�M�12�1TZ�H���&��_�7����=Q����,�Ҙ=�[�q'��Y!i��&u��eqTsT�Я@}I��m�	^�TՊ�i�^�0T�h�=~@��r1�Rx��r[:� }����jR��S@�R����`���ር1)孯��͹n��
Djtc�.��:hDg�+�r��T�A
C��y�����8�L�c?4$��%2+�Zb�����+>/(U�D��K8ЎÓ�(��v;��Me�
��0K��Cي��	-[ɎM��d�v��+Jo���j�!dJ��zC�lD����-2\�V7�"�H��\Pnfj9p���T�!+оI���Z����?������Ը�     